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
               'pospi' => bless( {
                                   'name' => '<Custom Code>',
                                   'code' => sub {
                                                 BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                 use strict;
                                                 no feature ':all';
                                                 use feature ':5.16';
                                                 require Math::BigFloat;
                                                 'Math::BigFloat'->new('3.14')->beq($_);
                                             },
                                   '_file' => '(eval 328)',
                                   '_lines' => [
                                                 6
                                               ],
                                   'operator' => 'CODE(...)'
                                 }, 'Test2::Compare::Custom' ),
               'negpi' => bless( {
                                   'name' => '<Custom Code>',
                                   'code' => sub {
                                                 BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                 use strict;
                                                 no feature ':all';
                                                 use feature ':5.16';
                                                 require Math::BigFloat;
                                                 'Math::BigFloat'->new('-3.14')->beq($_);
                                             },
                                   '_file' => '(eval 329)',
                                   '_lines' => [
                                                 6
                                               ],
                                   'operator' => 'CODE(...)'
                                 }, 'Test2::Compare::Custom' ),
               'pi' => bless( {
                                '_file' => '(eval 330)',
                                'code' => sub {
                                              BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                              use strict;
                                              no feature ':all';
                                              use feature ':5.16';
                                              require Math::BigFloat;
                                              'Math::BigFloat'->new('3.14')->beq($_);
                                          },
                                'name' => '<Custom Code>',
                                '_lines' => [
                                              6
                                            ],
                                'operator' => 'CODE(...)'
                              }, 'Test2::Compare::Custom' ),
               'zero-intpart' => bless( {
                                          '_lines' => [
                                                        6
                                                      ],
                                          'operator' => 'CODE(...)',
                                          'name' => '<Custom Code>',
                                          'code' => sub {
                                                        BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                        use strict;
                                                        no feature ':all';
                                                        use feature ':5.16';
                                                        require Math::BigFloat;
                                                        'Math::BigFloat'->new('0.123')->beq($_);
                                                    },
                                          '_file' => '(eval 331)'
                                        }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml(q{pi = 3.14
pospi = +3.14
negpi = -3.14
zero-intpart = 0.123
});

is($actual, $expected1, 'float - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $actual, 'float - to_toml') or do{
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