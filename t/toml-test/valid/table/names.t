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
               'a' => {
                        ' x ' => {},
                        'b' => {
                                 'c' => {}
                               },
                        'b.c' => {},
                        'd.e' => {}
                      },
               'd' => {
                        'e' => {
                                 'f' => {}
                               }
                      },
               'g' => {
                        'h' => {
                                 'i' => {}
                               }
                      },
               'j' => {
                        "\x{29e}" => {
                                       'l' => {}
                                     }
                      }
             };


my $actual = from_toml(q|[a.b.c]
[a."b.c"]
[a.'d.e']
[a.' x ']
[ d.e.f ]
[ g . h . i ]
[ j . "ʞ" . 'l' ]
|);

is($actual, $expected1, 'table/names - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $expected1, 'table/names - to_toml') or do{
  diag "ERROR: $@" if $@;

  diag 'INPUT:';
  diag Dumper($actual);

  diag '';
  diag 'GENERATED TOML:';
  diag to_toml($actual);

  diag '';
  diag 'REPARSED FROM GENERATED TOML:';
  diag Dumper(scalar from_toml(to_toml($actual)));
};

done_testing;