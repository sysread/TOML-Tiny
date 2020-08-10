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
               'zero' => bless( {
                                  '_file' => '(eval 332)',
                                  'operator' => 'CODE(...)',
                                  'code' => sub {
                                                BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                use strict;
                                                no feature ':all';
                                                use feature ':5.16';
                                                require Math::BigFloat;
                                                'Math::BigFloat'->new('3.0')->beq($_);
                                            },
                                  '_lines' => [
                                                6
                                              ],
                                  'name' => '<Custom Code>'
                                }, 'Test2::Compare::Custom' ),
               'neg' => bless( {
                                 'code' => sub {
                                               BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                               use strict;
                                               no feature ':all';
                                               use feature ':5.16';
                                               require Math::BigFloat;
                                               'Math::BigFloat'->new('0.03')->beq($_);
                                           },
                                 '_lines' => [
                                               6
                                             ],
                                 'name' => '<Custom Code>',
                                 '_file' => '(eval 333)',
                                 'operator' => 'CODE(...)'
                               }, 'Test2::Compare::Custom' ),
               'pointlower' => bless( {
                                        '_file' => '(eval 336)',
                                        'operator' => 'CODE(...)',
                                        'code' => sub {
                                                      BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                      use strict;
                                                      no feature ':all';
                                                      use feature ':5.16';
                                                      require Math::BigFloat;
                                                      'Math::BigFloat'->new('310.0')->beq($_);
                                                  },
                                        '_lines' => [
                                                      6
                                                    ],
                                        'name' => '<Custom Code>'
                                      }, 'Test2::Compare::Custom' ),
               'lower' => bless( {
                                   '_file' => '(eval 335)',
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
                                                 'Math::BigFloat'->new('300.0')->beq($_);
                                             }
                                 }, 'Test2::Compare::Custom' ),
               'pointupper' => bless( {
                                        '_file' => '(eval 334)',
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
                                                      'Math::BigFloat'->new('310.0')->beq($_);
                                                  }
                                      }, 'Test2::Compare::Custom' ),
               'upper' => bless( {
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
                                                 'Math::BigFloat'->new('300.0')->beq($_);
                                             },
                                   '_file' => '(eval 338)',
                                   'operator' => 'CODE(...)'
                                 }, 'Test2::Compare::Custom' ),
               'pos' => bless( {
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
                                               'Math::BigFloat'->new('300.0')->beq($_);
                                           },
                                 '_file' => '(eval 337)',
                                 'operator' => 'CODE(...)'
                               }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml(q{lower = 3e2
upper = 3E2
neg = 3e-2
pos = 3E+2
zero = 3e0
pointlower = 3.1e2
pointupper = 3.1E2
});

is($actual, $expected1, 'float-exponent - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ from_toml(to_toml($actual)) }, $actual, 'float-exponent - to_toml') or do{
  diag 'INPUT:';
  diag Dumper($actual);

  diag 'TOML OUTPUT:';
  diag to_toml($actual);

  diag 'REPARSED OUTPUT:';
  diag Dumper(from_toml(to_toml($actual)));
};

done_testing;