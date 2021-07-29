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
               '
' => 'newline',
               '"' => 'just a quote',
               '"quoted"' => {
                               'quote' => 1
                             },
               'a.b' => {
                          "\x{c0}" => {}
                        },
               'backsp' => {},
               "\x{c0}" => 'latin capital letter A with grave'
             };


my $actual = from_toml(q|"\\n" = "newline"
"\\u00c0" = "latin capital letter A with grave"
"\\"" = "just a quote"

["backsp\\b\\b"]

["\\"quoted\\""]
quote = true

["a.b"."\\u00c0"]
|);

is($actual, $expected1, 'key/escapes - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

is($error, U, 'key/escapes - to_toml - no errors');

is($reparsed, $expected1, 'key/escapes - to_toml') or do{
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