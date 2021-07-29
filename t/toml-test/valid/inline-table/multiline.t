# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use Data::Dumper;
use Math::BigInt;
use Math::BigFloat;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

my $expected1 = {
               'tbl_multiline' => {
                                    'a' => bless( {
                                                    '_file' => '(eval 447)',
                                                    '_lines' => [
                                                                  7
                                                                ],
                                                    'code' => sub {
                                                                  BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                                  use strict;
                                                                  no feature ':all';
                                                                  use feature ':5.16';
                                                                  require Math::BigInt;
                                                                  my $got = 'Math::BigInt'->new($_);
                                                                  'Math::BigInt'->new('1')->beq($got);
                                                              },
                                                    'name' => 'Math::BigInt->new("1")->beq($_)',
                                                    'operator' => 'CODE(...)'
                                                  }, 'Test2::Compare::Custom' ),
                                    'b' => 'multiline
',
                                    'c' => 'and yet
another line',
                                    'd' => bless( {
                                                    '_file' => '(eval 448)',
                                                    '_lines' => [
                                                                  7
                                                                ],
                                                    'code' => sub {
                                                                  BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                                  use strict;
                                                                  no feature ':all';
                                                                  use feature ':5.16';
                                                                  require Math::BigInt;
                                                                  my $got = 'Math::BigInt'->new($_);
                                                                  'Math::BigInt'->new('4')->beq($got);
                                                              },
                                                    'name' => 'Math::BigInt->new("4")->beq($_)',
                                                    'operator' => 'CODE(...)'
                                                  }, 'Test2::Compare::Custom' )
                                  }
             };


my $actual = from_toml(q|tbl_multiline = { a = 1, b = """
multiline
""", c = """and yet
another line""", d = 4 }
|);

is($actual, $expected1, 'inline-table/multiline - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'inline-table/multiline - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'inline-table/multiline - to_toml') or do{
  diag "ERROR: $error" if $error;

  diag 'INPUT:';
  diag Dumper($actual);

  diag '';
  diag 'REGENERATED TOML:';
  diag Dumper($regenerated);

  diag '';
  diag 'REPARSED FROM REGENERATED TOML:';
  diag Dumper($reparsed);
};

done_testing;