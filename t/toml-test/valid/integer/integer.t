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
               'answer' => bless( {
                                    '_file' => '(eval 454)',
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
                                                  'Math::BigInt'->new('42')->beq($got);
                                              },
                                    'name' => 'Math::BigInt->new("42")->beq($_)',
                                    'operator' => 'CODE(...)'
                                  }, 'Test2::Compare::Custom' ),
               'neganswer' => bless( {
                                       '_file' => '(eval 455)',
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
                                                     'Math::BigInt'->new('-42')->beq($got);
                                                 },
                                       'name' => 'Math::BigInt->new("-42")->beq($_)',
                                       'operator' => 'CODE(...)'
                                     }, 'Test2::Compare::Custom' ),
               'posanswer' => bless( {
                                       '_file' => '(eval 452)',
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
                                                     'Math::BigInt'->new('42')->beq($got);
                                                 },
                                       'name' => 'Math::BigInt->new("42")->beq($_)',
                                       'operator' => 'CODE(...)'
                                     }, 'Test2::Compare::Custom' ),
               'zero' => bless( {
                                  '_file' => '(eval 453)',
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
                                                'Math::BigInt'->new('0')->beq($got);
                                            },
                                  'name' => 'Math::BigInt->new("0")->beq($_)',
                                  'operator' => 'CODE(...)'
                                }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml(q|answer = 42
posanswer = +42
neganswer = -42
zero = 0
|);

is($actual, $expected1, 'integer/integer - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $expected1, 'integer/integer - to_toml') or do{
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