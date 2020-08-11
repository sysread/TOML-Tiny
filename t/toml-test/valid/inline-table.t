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
               'point' => {
                            'x' => bless( {
                                            'name' => '<Custom Code>',
                                            '_file' => '(eval 352)',
                                            'code' => sub {
                                                          BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                          use strict;
                                                          no feature ':all';
                                                          use feature ':5.16';
                                                          require Math::BigInt;
                                                          'Math::BigInt'->new('1')->beq($_);
                                                      },
                                            '_lines' => [
                                                          6
                                                        ],
                                            'operator' => 'CODE(...)'
                                          }, 'Test2::Compare::Custom' ),
                            'y' => bless( {
                                            '_file' => '(eval 351)',
                                            'code' => sub {
                                                          BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                          use strict;
                                                          no feature ':all';
                                                          use feature ':5.16';
                                                          require Math::BigInt;
                                                          'Math::BigInt'->new('2')->beq($_);
                                                      },
                                            'name' => '<Custom Code>',
                                            'operator' => 'CODE(...)',
                                            '_lines' => [
                                                          6
                                                        ]
                                          }, 'Test2::Compare::Custom' )
                          },
               'table-array' => [
                                  {
                                    'a' => bless( {
                                                    'name' => '<Custom Code>',
                                                    '_file' => '(eval 348)',
                                                    'code' => sub {
                                                                  BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                                  use strict;
                                                                  no feature ':all';
                                                                  use feature ':5.16';
                                                                  require Math::BigInt;
                                                                  'Math::BigInt'->new('1')->beq($_);
                                                              },
                                                    'operator' => 'CODE(...)',
                                                    '_lines' => [
                                                                  6
                                                                ]
                                                  }, 'Test2::Compare::Custom' )
                                  },
                                  {
                                    'b' => bless( {
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
                                                    '_file' => '(eval 349)'
                                                  }, 'Test2::Compare::Custom' )
                                  }
                                ],
               'str-key' => {
                              'a' => bless( {
                                              'name' => '<Custom Code>',
                                              'code' => sub {
                                                            BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                            use strict;
                                                            no feature ':all';
                                                            use feature ':5.16';
                                                            require Math::BigInt;
                                                            'Math::BigInt'->new('1')->beq($_);
                                                        },
                                              '_file' => '(eval 347)',
                                              '_lines' => [
                                                            6
                                                          ],
                                              'operator' => 'CODE(...)'
                                            }, 'Test2::Compare::Custom' )
                            },
               'name' => {
                           'first' => 'Tom',
                           'last' => 'Preston-Werner'
                         },
               'simple' => {
                             'a' => bless( {
                                             'name' => '<Custom Code>',
                                             '_file' => '(eval 350)',
                                             'code' => sub {
                                                           BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                           use strict;
                                                           no feature ':all';
                                                           use feature ':5.16';
                                                           require Math::BigInt;
                                                           'Math::BigInt'->new('1')->beq($_);
                                                       },
                                             '_lines' => [
                                                           6
                                                         ],
                                             'operator' => 'CODE(...)'
                                           }, 'Test2::Compare::Custom' )
                           }
             };


my $actual = from_toml(q{name = { first = "Tom", last = "Preston-Werner" }
point = { x = 1, y = 2 }
simple = { a = 1 }
str-key = { "a" = 1 }
table-array = [{ "a" = 1 }, { "b" = 2 }]
});

is($actual, $expected1, 'inline-table - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $actual, 'inline-table - to_toml') or do{
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