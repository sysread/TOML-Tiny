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
               'plain_table' => {
                                  'plain' => bless( {
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
                                                                    require Math::BigInt;
                                                                    'Math::BigInt'->new('3')->beq($_);
                                                                },
                                                      '_file' => '(eval 363)'
                                                    }, 'Test2::Compare::Custom' ),
                                  'with.dot' => bless( {
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
                                                                       require Math::BigInt;
                                                                       'Math::BigInt'->new('4')->beq($_);
                                                                   },
                                                         '_file' => '(eval 362)'
                                                       }, 'Test2::Compare::Custom' )
                                },
               'with.dot' => bless( {
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
                                                    require Math::BigInt;
                                                    'Math::BigInt'->new('2')->beq($_);
                                                },
                                      '_file' => '(eval 364)'
                                    }, 'Test2::Compare::Custom' ),
               'table' => {
                            'withdot' => {
                                           'plain' => bless( {
                                                               'name' => '<Custom Code>',
                                                               '_file' => '(eval 365)',
                                                               'code' => sub {
                                                                             BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                                             use strict;
                                                                             no feature ':all';
                                                                             use feature ':5.16';
                                                                             require Math::BigInt;
                                                                             'Math::BigInt'->new('5')->beq($_);
                                                                         },
                                                               '_lines' => [
                                                                             6
                                                                           ],
                                                               'operator' => 'CODE(...)'
                                                             }, 'Test2::Compare::Custom' ),
                                           'key.with.dots' => bless( {
                                                                       'name' => '<Custom Code>',
                                                                       'code' => sub {
                                                                                     BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                                                     use strict;
                                                                                     no feature ':all';
                                                                                     use feature ':5.16';
                                                                                     require Math::BigInt;
                                                                                     'Math::BigInt'->new('6')->beq($_);
                                                                                 },
                                                                       '_file' => '(eval 366)',
                                                                       'operator' => 'CODE(...)',
                                                                       '_lines' => [
                                                                                     6
                                                                                   ]
                                                                     }, 'Test2::Compare::Custom' )
                                         }
                          },
               'plain' => bless( {
                                   '_file' => '(eval 367)',
                                   'code' => sub {
                                                 BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                 use strict;
                                                 no feature ':all';
                                                 use feature ':5.16';
                                                 require Math::BigInt;
                                                 'Math::BigInt'->new('1')->beq($_);
                                             },
                                   'name' => '<Custom Code>',
                                   '_lines' => [
                                                 6
                                               ],
                                   'operator' => 'CODE(...)'
                                 }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml(q{plain = 1
"with.dot" = 2

[plain_table]
plain = 3
"with.dot" = 4

[table.withdot]
plain = 5
"key.with.dots" = 6});

is($actual, $expected1, 'keys-with-dots - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $actual, 'keys-with-dots - to_toml') or do{
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