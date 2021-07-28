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
               'name' => {
                           'first' => 'Tom',
                           'last' => 'Preston-Werner'
                         },
               'point' => {
                            'x' => bless( {
                                            '_file' => '(eval 427)',
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
                            'y' => bless( {
                                            '_file' => '(eval 428)',
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
                                                          'Math::BigInt'->new('2')->beq($got);
                                                      },
                                            'name' => 'Math::BigInt->new("2")->beq($_)',
                                            'operator' => 'CODE(...)'
                                          }, 'Test2::Compare::Custom' )
                          },
               'simple' => {
                             'a' => bless( {
                                             '_file' => '(eval 431)',
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
                                           }, 'Test2::Compare::Custom' )
                           },
               'str-key' => {
                              'a' => bless( {
                                              '_file' => '(eval 432)',
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
                                            }, 'Test2::Compare::Custom' )
                            },
               'table-array' => [
                                  {
                                    'a' => bless( {
                                                    '_file' => '(eval 429)',
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
                                                  }, 'Test2::Compare::Custom' )
                                  },
                                  {
                                    'b' => bless( {
                                                    '_file' => '(eval 430)',
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
                                                                  'Math::BigInt'->new('2')->beq($got);
                                                              },
                                                    'name' => 'Math::BigInt->new("2")->beq($_)',
                                                    'operator' => 'CODE(...)'
                                                  }, 'Test2::Compare::Custom' )
                                  }
                                ]
             };


my $actual = from_toml(q|name = { first = "Tom", last = "Preston-Werner" }
point = { x = 1, y = 2 }
simple = { a = 1 }
str-key = { "a" = 1 }
table-array = [{ "a" = 1 }, { "b" = 2 }]
|);

is($actual, $expected1, 'inline-table/inline-table - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $expected1, 'inline-table/inline-table - to_toml') or do{
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