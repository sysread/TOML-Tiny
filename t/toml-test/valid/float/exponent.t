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
               'lower' => bless( {
                                   '_file' => '(eval 393)',
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
                                                 'Math::BigFloat'->new('300.0')->beq($got);
                                             },
                                   'name' => 'Math::BigFloat->new("300.0")->beq($_)',
                                   'operator' => 'CODE(...)'
                                 }, 'Test2::Compare::Custom' ),
               'minustenth' => bless( {
                                        '_file' => '(eval 396)',
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
                                                      'Math::BigFloat'->new('-0.1')->beq($got);
                                                  },
                                        'name' => 'Math::BigFloat->new("-0.1")->beq($_)',
                                        'operator' => 'CODE(...)'
                                      }, 'Test2::Compare::Custom' ),
               'neg' => bless( {
                                 '_file' => '(eval 394)',
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
                                               'Math::BigFloat'->new('0.03')->beq($got);
                                           },
                                 'name' => 'Math::BigFloat->new("0.03")->beq($_)',
                                 'operator' => 'CODE(...)'
                               }, 'Test2::Compare::Custom' ),
               'pointlower' => bless( {
                                        '_file' => '(eval 392)',
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
                                                      'Math::BigFloat'->new('310.0')->beq($got);
                                                  },
                                        'name' => 'Math::BigFloat->new("310.0")->beq($_)',
                                        'operator' => 'CODE(...)'
                                      }, 'Test2::Compare::Custom' ),
               'pointupper' => bless( {
                                        '_file' => '(eval 395)',
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
                                                      'Math::BigFloat'->new('310.0')->beq($got);
                                                  },
                                        'name' => 'Math::BigFloat->new("310.0")->beq($_)',
                                        'operator' => 'CODE(...)'
                                      }, 'Test2::Compare::Custom' ),
               'pos' => bless( {
                                 '_file' => '(eval 391)',
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
                                               'Math::BigFloat'->new('300.0')->beq($got);
                                           },
                                 'name' => 'Math::BigFloat->new("300.0")->beq($_)',
                                 'operator' => 'CODE(...)'
                               }, 'Test2::Compare::Custom' ),
               'upper' => bless( {
                                   '_file' => '(eval 397)',
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
                                                 'Math::BigFloat'->new('300.0')->beq($got);
                                             },
                                   'name' => 'Math::BigFloat->new("300.0")->beq($_)',
                                   'operator' => 'CODE(...)'
                                 }, 'Test2::Compare::Custom' ),
               'zero' => bless( {
                                  '_file' => '(eval 390)',
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
                                                'Math::BigFloat'->new('3.0')->beq($got);
                                            },
                                  'name' => 'Math::BigFloat->new("3.0")->beq($_)',
                                  'operator' => 'CODE(...)'
                                }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml(q|lower = 3e2
upper = 3E2
neg = 3e-2
pos = 3E+2
zero = 3e0
pointlower = 3.1e2
pointupper = 3.1E2
minustenth = -1E-1
|);

is($actual, $expected1, 'float/exponent - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'float/exponent - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'float/exponent - to_toml') or do{
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