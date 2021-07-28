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
               'arr_arr_tbl_empty' => [
                                        [
                                          {}
                                        ]
                                      ],
               'arr_arr_tbl_val' => [
                                      [
                                        {
                                          'one' => bless( {
                                                            '_file' => '(eval 451)',
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
                                        }
                                      ]
                                    ],
               'arr_arr_tbls' => [
                                   [
                                     {
                                       'one' => bless( {
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
                                                                       'Math::BigInt'->new('1')->beq($got);
                                                                   },
                                                         'name' => 'Math::BigInt->new("1")->beq($_)',
                                                         'operator' => 'CODE(...)'
                                                       }, 'Test2::Compare::Custom' )
                                     },
                                     {
                                       'two' => bless( {
                                                         '_file' => '(eval 449)',
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
                                 ],
               'arr_tbl_tbl' => [
                                  {
                                    'tbl' => {
                                               'one' => bless( {
                                                                 '_file' => '(eval 450)',
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
                                             }
                                  }
                                ],
               'tbl_arr_tbl' => {
                                  'arr_tbl' => [
                                                 {
                                                   'one' => bless( {
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
                                                                   }, 'Test2::Compare::Custom' )
                                                 }
                                               ]
                                },
               'tbl_tbl_empty' => {
                                    'tbl_0' => {}
                                  },
               'tbl_tbl_val' => {
                                  'tbl_1' => {
                                               'one' => bless( {
                                                                 '_file' => '(eval 446)',
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
                                             }
                                }
             };


my $actual = from_toml(q|tbl_tbl_empty = { tbl_0 = {} }
tbl_tbl_val   = { tbl_1 = { one = 1 } }
tbl_arr_tbl   = { arr_tbl = [ { one = 1 } ] }
arr_tbl_tbl   = [ { tbl = { one = 1 } } ]

# Array-of-array-of-table is interesting because it can only
# be represented in inline form.
arr_arr_tbl_empty = [ [ {} ] ]
arr_arr_tbl_val = [ [ { one = 1 } ] ]
arr_arr_tbls  = [ [ { one = 1 }, { two = 2 } ] ]
|);

is($actual, $expected1, 'inline-table/nest - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $expected1, 'inline-table/nest - to_toml') or do{
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