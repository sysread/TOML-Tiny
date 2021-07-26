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
               'posanswer' => bless( {
                                       'operator' => 'CODE(...)',
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
                                       '_file' => '(eval 354)'
                                     }, 'Test2::Compare::Custom' ),
               'zero' => bless( {
                                  'code' => sub {
                                                BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                use strict;
                                                no feature ':all';
                                                use feature ':5.16';
                                                require Math::BigInt;
                                                my $got = 'Math::BigInt'->new($_);
                                                'Math::BigInt'->new('0')->beq($got);
                                            },
                                  '_lines' => [
                                                7
                                              ],
                                  'operator' => 'CODE(...)',
                                  '_file' => '(eval 356)',
                                  'name' => 'Math::BigInt->new("0")->beq($_)'
                                }, 'Test2::Compare::Custom' ),
               'answer' => bless( {
                                    'code' => sub {
                                                  BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                  use strict;
                                                  no feature ':all';
                                                  use feature ':5.16';
                                                  require Math::BigInt;
                                                  my $got = 'Math::BigInt'->new($_);
                                                  'Math::BigInt'->new('42')->beq($got);
                                              },
                                    '_lines' => [
                                                  7
                                                ],
                                    'operator' => 'CODE(...)',
                                    '_file' => '(eval 355)',
                                    'name' => 'Math::BigInt->new("42")->beq($_)'
                                  }, 'Test2::Compare::Custom' ),
               'neganswer' => bless( {
                                       '_lines' => [
                                                     7
                                                   ],
                                       'operator' => 'CODE(...)',
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
                                       '_file' => '(eval 353)'
                                     }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml(q{answer = 42
posanswer = +42
neganswer = -42
zero = 0
});

is($actual, $expected1, 'integer - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $expected1, 'integer - to_toml') or do{
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