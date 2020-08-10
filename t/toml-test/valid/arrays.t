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
               'strings' => [
                              'a',
                              'b',
                              'c'
                            ],
               'floats' => [
                             bless( {
                                      '_lines' => [
                                                    6
                                                  ],
                                      'code' => sub {
                                                    BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                    use strict;
                                                    no feature ':all';
                                                    use feature ':5.16';
                                                    require Math::BigFloat;
                                                    'Math::BigFloat'->new('1.1')->beq($_);
                                                },
                                      'name' => '<Custom Code>',
                                      'operator' => 'CODE(...)',
                                      '_file' => '(eval 304)'
                                    }, 'Test2::Compare::Custom' ),
                             bless( {
                                      '_file' => '(eval 305)',
                                      'operator' => 'CODE(...)',
                                      'code' => sub {
                                                    BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                    use strict;
                                                    no feature ':all';
                                                    use feature ':5.16';
                                                    require Math::BigFloat;
                                                    'Math::BigFloat'->new('2.1')->beq($_);
                                                },
                                      '_lines' => [
                                                    6
                                                  ],
                                      'name' => '<Custom Code>'
                                    }, 'Test2::Compare::Custom' ),
                             bless( {
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
                                                    'Math::BigFloat'->new('3.1')->beq($_);
                                                },
                                      'operator' => 'CODE(...)',
                                      '_file' => '(eval 306)'
                                    }, 'Test2::Compare::Custom' )
                           ],
               'dates' => [
                            bless( {
                                     '_file' => '(eval 80)',
                                     'operator' => 'CODE(...)',
                                     'name' => '<Custom Code>',
                                     '_lines' => [
                                                   11
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
                                               }
                                   }, 'Test2::Compare::Custom' ),
                            bless( {
                                     '_file' => '(eval 300)',
                                     'operator' => 'CODE(...)',
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
                                     '_lines' => [
                                                   11
                                                 ],
                                     'name' => '<Custom Code>'
                                   }, 'Test2::Compare::Custom' ),
                            bless( {
                                     'operator' => 'CODE(...)',
                                     '_file' => '(eval 301)',
                                     '_lines' => [
                                                   11
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
                                     'name' => '<Custom Code>'
                                   }, 'Test2::Compare::Custom' )
                          ],
               'comments' => [
                               bless( {
                                        '_lines' => [
                                                      6
                                                    ],
                                        'code' => sub {
                                                      BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                      use strict;
                                                      no feature ':all';
                                                      use feature ':5.16';
                                                      require Math::BigInt;
                                                      'Math::BigInt'->new('1')->beq($_);
                                                  },
                                        'name' => '<Custom Code>',
                                        '_file' => '(eval 302)',
                                        'operator' => 'CODE(...)'
                                      }, 'Test2::Compare::Custom' ),
                               bless( {
                                        '_file' => '(eval 303)',
                                        'operator' => 'CODE(...)',
                                        '_lines' => [
                                                      6
                                                    ],
                                        'code' => sub {
                                                      BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                      use strict;
                                                      no feature ':all';
                                                      use feature ':5.16';
                                                      require Math::BigInt;
                                                      'Math::BigInt'->new('2')->beq($_);
                                                  },
                                        'name' => '<Custom Code>'
                                      }, 'Test2::Compare::Custom' )
                             ],
               'ints' => [
                           bless( {
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
                                                  'Math::BigInt'->new('1')->beq($_);
                                              },
                                    '_file' => '(eval 307)',
                                    'operator' => 'CODE(...)'
                                  }, 'Test2::Compare::Custom' ),
                           bless( {
                                    '_file' => '(eval 308)',
                                    'operator' => 'CODE(...)',
                                    'code' => sub {
                                                  BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                  use strict;
                                                  no feature ':all';
                                                  use feature ':5.16';
                                                  require Math::BigInt;
                                                  'Math::BigInt'->new('2')->beq($_);
                                              },
                                    '_lines' => [
                                                  6
                                                ],
                                    'name' => '<Custom Code>'
                                  }, 'Test2::Compare::Custom' ),
                           bless( {
                                    'operator' => 'CODE(...)',
                                    '_file' => '(eval 309)',
                                    'code' => sub {
                                                  BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                  use strict;
                                                  no feature ':all';
                                                  use feature ':5.16';
                                                  require Math::BigInt;
                                                  'Math::BigInt'->new('3')->beq($_);
                                              },
                                    '_lines' => [
                                                  6
                                                ],
                                    'name' => '<Custom Code>'
                                  }, 'Test2::Compare::Custom' )
                         ]
             };


my $actual = from_toml(q{ints = [1, 2, 3]
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
});

is($actual, $expected1, 'arrays - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ from_toml(to_toml($actual)) }, $actual, 'arrays - to_toml') or do{
  diag 'INPUT:';
  diag Dumper($actual);

  diag 'TOML OUTPUT:';
  diag to_toml($actual);

  diag 'REPARSED OUTPUT:';
  diag Dumper(from_toml(to_toml($actual)));
};

done_testing;