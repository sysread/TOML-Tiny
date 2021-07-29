# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use Data::Dumper;
use Test2::Require::Module 'DateTime';
use Test2::Require::Module 'DateTime::Format::RFC3339';
use DateTime;
use DateTime::Format::RFC3339;
use Math::BigInt;
use Math::BigFloat;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

my $expected1 = {
               'comments' => [
                               bless( {
                                        '_file' => '(eval 48)',
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
                                        '_file' => '(eval 114)',
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
                             ],
               'dates' => [
                            bless( {
                                     '_file' => '(eval 118)',
                                     '_lines' => [
                                                   13
                                                 ],
                                     'code' => sub {
                                                   BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                   use strict;
                                                   no feature ':all';
                                                   use feature ':5.16';
                                                   my $exp = 'DateTime::Format::RFC3339'->parse_datetime('1987-07-05T17:45:00Z');
                                                   my $got = 'DateTime::Format::RFC3339'->parse_datetime($_);
                                                   $exp->set_time_zone('UTC');
                                                   $got->set_time_zone('UTC');
                                                   return 'DateTime'->compare($got, $exp) == 0;
                                               },
                                     'name' => '<Custom Code>',
                                     'operator' => 'CODE(...)'
                                   }, 'Test2::Compare::Custom' ),
                            bless( {
                                     '_file' => '(eval 324)',
                                     '_lines' => [
                                                   13
                                                 ],
                                     'code' => sub {
                                                   BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                   use strict;
                                                   no feature ':all';
                                                   use feature ':5.16';
                                                   my $exp = 'DateTime::Format::RFC3339'->parse_datetime('1979-05-27T07:32:00Z');
                                                   my $got = 'DateTime::Format::RFC3339'->parse_datetime($_);
                                                   $exp->set_time_zone('UTC');
                                                   $got->set_time_zone('UTC');
                                                   return 'DateTime'->compare($got, $exp) == 0;
                                               },
                                     'name' => '<Custom Code>',
                                     'operator' => 'CODE(...)'
                                   }, 'Test2::Compare::Custom' ),
                            bless( {
                                     '_file' => '(eval 325)',
                                     '_lines' => [
                                                   13
                                                 ],
                                     'code' => sub {
                                                   BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                   use strict;
                                                   no feature ':all';
                                                   use feature ':5.16';
                                                   my $exp = 'DateTime::Format::RFC3339'->parse_datetime('2006-06-01T11:00:00Z');
                                                   my $got = 'DateTime::Format::RFC3339'->parse_datetime($_);
                                                   $exp->set_time_zone('UTC');
                                                   $got->set_time_zone('UTC');
                                                   return 'DateTime'->compare($got, $exp) == 0;
                                               },
                                     'name' => '<Custom Code>',
                                     'operator' => 'CODE(...)'
                                   }, 'Test2::Compare::Custom' )
                          ],
               'floats' => [
                             bless( {
                                      '_file' => '(eval 326)',
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
                                                    'Math::BigFloat'->new('1.1')->beq($got);
                                                },
                                      'name' => 'Math::BigFloat->new("1.1")->beq($_)',
                                      'operator' => 'CODE(...)'
                                    }, 'Test2::Compare::Custom' ),
                             bless( {
                                      '_file' => '(eval 327)',
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
                                                    'Math::BigFloat'->new('2.1')->beq($got);
                                                },
                                      'name' => 'Math::BigFloat->new("2.1")->beq($_)',
                                      'operator' => 'CODE(...)'
                                    }, 'Test2::Compare::Custom' ),
                             bless( {
                                      '_file' => '(eval 328)',
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
                                                    'Math::BigFloat'->new('3.1')->beq($got);
                                                },
                                      'name' => 'Math::BigFloat->new("3.1")->beq($_)',
                                      'operator' => 'CODE(...)'
                                    }, 'Test2::Compare::Custom' )
                           ],
               'ints' => [
                           bless( {
                                    '_file' => '(eval 115)',
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
                                    '_file' => '(eval 116)',
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
                                    '_file' => '(eval 117)',
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
                                  }, 'Test2::Compare::Custom' )
                         ],
               'strings' => [
                              'a',
                              'b',
                              'c'
                            ]
             };


my $actual = from_toml(q|ints = [1, 2, 3, ]
floats = [1.1, 2.1, 3.1]
strings = ["a", "b", "c"]
dates = [
  1987-07-05T17:45:00Z,
  1979-05-27T07:32:00Z,
  2006-06-01T11:00:00Z,
]
comments = [
         1,
         2, #this is ok
]
|);

is($actual, $expected1, 'array/array - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'array/array - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'array/array - to_toml') or do{
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