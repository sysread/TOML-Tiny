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
               'plain' => bless( {
                                   '_file' => '(eval 509)',
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
               'plain_table' => {
                                  'plain' => bless( {
                                                      '_file' => '(eval 506)',
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
                                                                    'Math::BigInt'->new('3')->beq($got);
                                                                },
                                                      'name' => 'Math::BigInt->new("3")->beq($_)',
                                                      'operator' => 'CODE(...)'
                                                    }, 'Test2::Compare::Custom' ),
                                  'with.dot' => bless( {
                                                         '_file' => '(eval 507)',
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
                                },
               'table' => {
                            'withdot' => {
                                           'key.with.dots' => bless( {
                                                                       '_file' => '(eval 504)',
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
                                                                                     'Math::BigInt'->new('6')->beq($got);
                                                                                 },
                                                                       'name' => 'Math::BigInt->new("6")->beq($_)',
                                                                       'operator' => 'CODE(...)'
                                                                     }, 'Test2::Compare::Custom' ),
                                           'plain' => bless( {
                                                               '_file' => '(eval 505)',
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
                                                                             'Math::BigInt'->new('5')->beq($got);
                                                                         },
                                                               'name' => 'Math::BigInt->new("5")->beq($_)',
                                                               'operator' => 'CODE(...)'
                                                             }, 'Test2::Compare::Custom' )
                                         }
                          },
               'with.dot' => bless( {
                                      '_file' => '(eval 508)',
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
             };


my $actual = from_toml(q|plain = 1
"with.dot" = 2

[plain_table]
plain = 3
"with.dot" = 4

[table.withdot]
plain = 5
"key.with.dots" = 6
|);

is($actual, $expected1, 'key/quoted-dots - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $expected1, 'key/quoted-dots - to_toml') or do{
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