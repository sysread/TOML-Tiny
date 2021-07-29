#-------------------------------------------------------------------------------
# Generates perl unit tests from the toml/json files in BurntSush/toml-test
# without having to add special casing to TOML::Tiny to conform to their
# annotated JSON format.
#-------------------------------------------------------------------------------
use strict;
use warnings;
no warnings 'experimental';
use v5.18;

use Data::Dumper;
use JSON::PP;
use File::Copy;
use File::Find;
use File::Spec;

# We want to read unicde as characters from toml-test source files. That makes
# things simpler for us when we parse them and generate perl source in the
# generated test file.
binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

sub slurp{
  open my $fh, '<', $_[0] or die $!;
  local $/;
  <$fh>;
}

# Removes type annotations from BurntSushi/toml-test JSON files and returns the
# cleaned up data structure to which the associated TOML file should be parsed.
sub deturd_json{
  state $json = JSON::PP->new->utf8(1);
  my $annotated = $json->decode(slurp(shift));
  my $cleanish = deannotate($annotated);

  local $Data::Dumper::Varname  = 'expected';
  local $Data::Dumper::Deparse  = 1;
  local $Data::Dumper::Sortkeys = 1;
  return Dumper($cleanish);
}

# Recursively deannotates and inflates values from toml-test JSON data
# structures into a format more in line with TOML::Tiny's parser outout. For
# integer and float values, a Test2::Tools::Compare validator is generated to
# compare using Math::Big(Int|Float)->beq, since TOML's float and int types are
# 64 bits. Datetimes are converted to a common, normalized string format.
sub deannotate{
  my $data = shift;

  for (ref $data) {
    when ('HASH') {
      if (exists $data->{type} && exists $data->{value} && keys(%$data) == 2) {
        for ($data->{type}) {
          return $data->{value} eq 'true' ? 1 : 0             when /bool/;
          return [ map{ deannotate($_) } @{$data->{value}} ]  when /array/;

          when (/datetime/) {
            my $src = qq{
              use Test2::Tools::Compare qw(validator);
              validator(sub{
                use Test2::Require::Module 'DateTime';
                use Test2::Require::Module 'DateTime::Format::RFC3339';
                use DateTime;
                use DateTime::Format::RFC3339;
                my \$exp = DateTime::Format::RFC3339->parse_datetime("$data->{value}");
                my \$got = DateTime::Format::RFC3339->parse_datetime(\$_);
                \$exp->set_time_zone('UTC');
                \$got->set_time_zone('UTC');
                return DateTime->compare(\$got, \$exp) == 0;
              });
            };

            my $result = eval $src;
            $@ && die $@;

            return $result;
          }

          when (/integer/) {
            my $src = qq{
              use Test2::Tools::Compare qw(validator);
              validator('Math::BigInt->new("$data->{value}")->beq(\$_)' => sub{
                require Math::BigInt;
                my \$got = Math::BigInt->new(\$_);
                Math::BigInt->new("$data->{value}")->beq(\$got);
              });
            };

            my $result = eval $src;
            $@ && die $@;

            return $result;
          }

          when (/float/) {
            my $src;

            if ($data->{value} eq 'nan') {
              $src = qq{
                use Test2::Tools::Compare qw(validator);
                validator('Math::BigFloat->new(\$_)->is_nan' => sub{
                  require Math::BigFloat;
                  Math::BigFloat->new(\$_)->is_nan;
                });
              };
            }
            elsif ($data->{value} eq 'inf') {
              $src = qq{
                use Test2::Tools::Compare qw(validator);
                validator('Math::BigFloat->new(\$_)->is_inf' => sub{
                  require Math::BigFloat;
                  Math::BigFloat->new(\$_)->is_inf;
                });
              };
            }
            elsif ($data->{value} eq '-inf') {
              $src = qq{
                use Test2::Tools::Compare qw(validator);
                validator('Math::BigFloat->new(\$_)->is_inf' => sub{
                  require Math::BigFloat;
                  Math::BigFloat->new(\$_)->is_inf;
                });
              };
            }
            else {
              $src = qq{
                use Test2::Tools::Compare qw(validator);
                validator('Math::BigFloat->new("$data->{value}")->beq(\$_)' => sub{
                  require Math::BigFloat;
                  my \$got = Math::BigFloat->new(\$_);
                  Math::BigFloat->new("$data->{value}")->beq(\$got);
                });
              };
            }

            my $result = eval $src;
            $@ && die $@;

            return $result;
          }

          default{ return $data->{value} }
        }
      }

      my %object;
      $object{$_} = deannotate($data->{$_}) for keys %$data;
      return \%object;
    }

    when ('ARRAY') {
      return [ map{ deannotate($_) } @$data ];
    }

    default{
      return $data;
    }
  }
}

sub find_tests{
  my $src = shift;
  my %tests;
  find {
    no_chdir => 1,
    wanted => sub {
      return unless /\.toml$/;

      my $abs = File::Spec->rel2abs( $_ );
      my $rel = File::Spec->abs2rel( $abs, $src );

      my $toml = $rel;
      my $test = substr $rel, 0, -5;

      $tests{$test} = $toml;
    },
  } => $src;
  return %tests;
}

sub build_pospath_test_files{
  my $src  = shift;
  my $dest = shift;

  $src = "$src/tests/valid";
  $dest = "$dest/t/toml-test/valid";

  print "Generating positive path tests from $src\n";

  my %TOML = find_tests( $src );

  for (sort keys %TOML) {
    my $json = substr( $TOML{$_}, 0, -4 ) . 'json';
    my $data = deturd_json("$src/$json");
    my $test = "$dest/$_.t";

    my $toml = slurp("$src/$TOML{$_}");
    $toml =~ s/\\/\\\\/g;
    $toml =~ s/\|/\\|/g;

    my ( undef, $path ) = File::Spec->splitpath( $test );
    unless (-f $test) {
      system('mkdir', '-p', $path) == 0 || die $?;
    }

    open my $fh, '>', $test or die $!;

    my $optional_deps = '';
    if ( $data =~ /DateTime/ ) {
        $optional_deps = <<'DEPS';

use Test2::Require::Module 'DateTime';
use Test2::Require::Module 'DateTime::Format::RFC3339';
use DateTime;
use DateTime::Format::RFC3339;
DEPS
        chomp $optional_deps;
    }

    print $fh qq{# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use Data::Dumper;$optional_deps
use Math::BigInt;
use Math::BigFloat;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

my $data

my \$actual = from_toml(q|$toml|);

is(\$actual, \$expected1, '$_ - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper(\$expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper(\$actual);
};

my \$regenerated = to_toml \$actual;
my \$reparsed    = eval{ scalar from_toml \$regenerated };
my \$error       = \$@;

ok(!\$error, '$_ - to_toml - no errors')
  or diag \$error;

is(\$reparsed, \$expected1, '$_ - to_toml') or do{
  diag "ERROR: \$error" if \$error;

  diag 'INPUT:';
  diag Dumper(\$actual);

  diag '';
  diag 'REGENERATED TOML:';
  diag Dumper(\$regenerated);

  diag '';
  diag 'REPARSED FROM REGENERATED TOML:';
  diag Dumper(\$reparsed);
};

done_testing;};

    close $fh;
  }
}

sub build_negpath_test_files{
  my $src  = shift;
  my $dest = shift;

  $src = "$src/tests/invalid";
  $dest = "$dest/t/toml-test/invalid";

  print "Generating negative path tests from $src\n";

  my %TOML = find_tests( $src );

  for (sort keys %TOML) {
    copy("$src/$TOML{$_}", "$dest/$TOML{$_}");

    my $test = "$dest/$_.t";
    my ( undef, $path ) = File::Spec->splitpath( $test );
    unless (-f $test) {
      system('mkdir', '-p', $path) == 0 || die $?;
    }

    open my $fh, '>', $test or die $!;

    print $fh qq{# File automatically generated from BurntSushi/toml-test
use Test2::V0;
use TOML::Tiny;

open my \$fh, '<', "$dest/$TOML{$_}" or die \$!;
my \$toml = do{ local \$/; <\$fh>; };
close \$fh;

ok dies(sub{ scalar from_toml(\$toml, strict => 1) }), 'strict_mode dies on $_';

done_testing;};

    close $fh;
  }
}

my $usage = "usage: build-tests \$toml-test-repo-path \$toml-tiny-repo-path\n";
my $toml_test_path = shift @ARGV || die $usage;
my $toml_tiny_path = shift @ARGV || die $usage;

-d $toml_test_path          || die "invalid path to BurntSushi/toml-test: $toml_test_path\n";
-d "$toml_test_path/tests"  || die "invalid path to BurntSushi/toml-test: $toml_test_path\n";
-d $toml_tiny_path          || die "invalid path to TOML::Tiny repo: $toml_tiny_path\n";
-d "$toml_tiny_path/t"      || die "invalid path to TOML::Tiny repo: $toml_tiny_path\n";

print "Checking out master branch of BurntSushi/toml-test and pulling the latest commits\n";
system("cd $toml_test_path && git checkout master && git pull") == 0 || die $!;

build_pospath_test_files($toml_test_path, $toml_tiny_path);
build_negpath_test_files($toml_test_path, $toml_tiny_path);
