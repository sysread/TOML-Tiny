# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use Data::Dumper;
use DateTime;
use DateTime::Format::RFC3339;
use Math::BigInt;
use Math::BigFloat;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

my $expected1 = {
               'beast' => bless( {
                                   'operator' => 'CODE(...)',
                                   '_lines' => [
                                                 6
                                               ],
                                   'name' => '<Custom Code>',
                                   'code' => sub {
                                                 BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                 use strict;
                                                 no feature ':all';
                                                 use feature ':5.16';
                                                 require Math::BigFloat;
                                                 'Math::BigFloat'->new('666')->beq($_);
                                             },
                                   '_file' => '(eval 327)'
                                 }, 'Test2::Compare::Custom' ),
               'minustenth' => bless( {
                                        'name' => '<Custom Code>',
                                        '_file' => '(eval 325)',
                                        'code' => sub {
                                                      BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                      use strict;
                                                      no feature ':all';
                                                      use feature ':5.16';
                                                      require Math::BigFloat;
                                                      'Math::BigFloat'->new('-0.1')->beq($_);
                                                  },
                                        '_lines' => [
                                                      6
                                                    ],
                                        'operator' => 'CODE(...)'
                                      }, 'Test2::Compare::Custom' ),
               'million' => bless( {
                                     '_lines' => [
                                                   6
                                                 ],
                                     'operator' => 'CODE(...)',
                                     'code' => sub {
                                                   BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                   use strict;
                                                   no feature ':all';
                                                   use feature ':5.16';
                                                   require Math::BigFloat;
                                                   'Math::BigFloat'->new('1000000')->beq($_);
                                               },
                                     '_file' => '(eval 326)',
                                     'name' => '<Custom Code>'
                                   }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml(q{million = 1e6
minustenth = -1E-1
beast = 6.66E2
});

is($actual, $expected1, 'exponent-part-float - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $actual, 'exponent-part-float - to_toml') or do{
  diag 'INPUT:';
  diag Dumper($actual);

  diag '';
  diag 'TOML OUTPUT:';
  diag to_toml($actual);

  diag '';
  diag 'REPARSED OUTPUT:';
  diag Dumper(scalar from_toml(to_toml($actual)));
};

done_testing;