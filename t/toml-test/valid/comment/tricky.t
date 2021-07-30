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
               'hash#tag' => {
                               '#!' => 'hash bang',
                               'arr3' => [
                                           '#',
                                           '#',
                                           '###'
                                         ],
                               'arr4' => [
                                           bless( {
                                                    '_file' => '(eval 160)',
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
                                           bless( {
                                                    '_file' => '(eval 161)',
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
                                                  }, 'Test2::Compare::Custom' ),
                                           bless( {
                                                    '_file' => '(eval 162)',
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
                                           bless( {
                                                    '_file' => '(eval 163)',
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
                                         ],
                               'arr5' => [
                                           [
                                             [
                                               [
                                                 [
                                                   '#'
                                                 ]
                                               ]
                                             ]
                                           ]
                                         ],
                               'tbl1' => {
                                           '#' => '}#'
                                         }
                             },
               'section' => {
                              '8' => 'eight',
                              'eleven' => bless( {
                                                   '_file' => '(eval 159)',
                                                   '_lines' => [
                                                                 7
                                                               ],
                                                   'code' => sub {
                                                                 BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                                 use strict;
                                                                 no feature ':all';
                                                                 use feature ':5.16';
                                                                 require Math::BigFloat;
                                                                 my $got = 'Math::BigFloat'->new($_);
                                                                 'Math::BigFloat'->new('11.1')->beq($got);
                                                             },
                                                   'name' => 'Math::BigFloat->new("11.1")->beq($_)',
                                                   'operator' => 'CODE(...)'
                                                 }, 'Test2::Compare::Custom' ),
                              'five' => bless( {
                                                 '_file' => '(eval 156)',
                                                 '_lines' => [
                                                               7
                                                             ],
                                                 'code' => sub {
                                                               BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                               use strict;
                                                               no feature ':all';
                                                               use feature ':5.16';
                                                               require Math::BigFloat;
                                                               my $got = 'Math::BigFloat'->new($_);
                                                               'Math::BigFloat'->new('5.5')->beq($got);
                                                           },
                                                 'name' => 'Math::BigFloat->new("5.5")->beq($_)',
                                                 'operator' => 'CODE(...)'
                                               }, 'Test2::Compare::Custom' ),
                              'four' => '# no comment
# nor this
#also not comment',
                              'one' => '11',
                              'six' => bless( {
                                                '_file' => '(eval 157)',
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
                              'ten' => bless( {
                                                '_file' => '(eval 158)',
                                                '_lines' => [
                                                              7
                                                            ],
                                                'code' => sub {
                                                              BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                              use strict;
                                                              no feature ':all';
                                                              use feature ':5.16';
                                                              require Math::BigFloat;
                                                              my $got = 'Math::BigFloat'->new($_);
                                                              'Math::BigFloat'->new('1000.0')->beq($got);
                                                          },
                                                'name' => 'Math::BigFloat->new("1000.0")->beq($_)',
                                                'operator' => 'CODE(...)'
                                              }, 'Test2::Compare::Custom' ),
                              'three' => '#',
                              'two' => '22#'
                            }
             };


my $actual = from_toml(q|[section]#attached comment
#[notsection]
one = "11"#cmt
two = "22#"
three = '#'

four = """# no comment
# nor this
#also not comment"""#is_comment

five = 5.5#66
six = 6#7
8 = "eight"
#nine = 99
ten = 10e2#1
eleven = 1.11e1#23

["hash#tag"]
"#!" = "hash bang"
arr3 = [ "#", '#', """###""" ]
arr4 = [ 1,# 9, 9,
2#,9
,#9
3#]
,4]
arr5 = [[[[#["#"],
["#"]]]]#]
]
tbl1 = { "#" = '}#'}#}}


|);

is($actual, $expected1, 'comment/tricky - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'comment/tricky - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'comment/tricky - to_toml') or do{
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