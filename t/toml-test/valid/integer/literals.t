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
               'bin1' => bless( {
                                  '_file' => '(eval 465)',
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
                                                'Math::BigInt'->new('214')->beq($got);
                                            },
                                  'name' => 'Math::BigInt->new("214")->beq($_)',
                                  'operator' => 'CODE(...)'
                                }, 'Test2::Compare::Custom' ),
               'bin2' => bless( {
                                  '_file' => '(eval 461)',
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
                                }, 'Test2::Compare::Custom' ),
               'hex1' => bless( {
                                  '_file' => '(eval 459)',
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
                                                'Math::BigInt'->new('3735928559')->beq($got);
                                            },
                                  'name' => 'Math::BigInt->new("3735928559")->beq($_)',
                                  'operator' => 'CODE(...)'
                                }, 'Test2::Compare::Custom' ),
               'hex2' => bless( {
                                  '_file' => '(eval 466)',
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
                                                'Math::BigInt'->new('3735928559')->beq($got);
                                            },
                                  'name' => 'Math::BigInt->new("3735928559")->beq($_)',
                                  'operator' => 'CODE(...)'
                                }, 'Test2::Compare::Custom' ),
               'hex3' => bless( {
                                  '_file' => '(eval 464)',
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
                                                'Math::BigInt'->new('3735928559')->beq($got);
                                            },
                                  'name' => 'Math::BigInt->new("3735928559")->beq($_)',
                                  'operator' => 'CODE(...)'
                                }, 'Test2::Compare::Custom' ),
               'hex4' => bless( {
                                  '_file' => '(eval 462)',
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
                                                'Math::BigInt'->new('2439')->beq($got);
                                            },
                                  'name' => 'Math::BigInt->new("2439")->beq($_)',
                                  'operator' => 'CODE(...)'
                                }, 'Test2::Compare::Custom' ),
               'oct1' => bless( {
                                  '_file' => '(eval 467)',
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
                                                'Math::BigInt'->new('342391')->beq($got);
                                            },
                                  'name' => 'Math::BigInt->new("342391")->beq($_)',
                                  'operator' => 'CODE(...)'
                                }, 'Test2::Compare::Custom' ),
               'oct2' => bless( {
                                  '_file' => '(eval 460)',
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
                                                'Math::BigInt'->new('493')->beq($got);
                                            },
                                  'name' => 'Math::BigInt->new("493")->beq($_)',
                                  'operator' => 'CODE(...)'
                                }, 'Test2::Compare::Custom' ),
               'oct3' => bless( {
                                  '_file' => '(eval 463)',
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
                                                'Math::BigInt'->new('501')->beq($got);
                                            },
                                  'name' => 'Math::BigInt->new("501")->beq($_)',
                                  'operator' => 'CODE(...)'
                                }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml(q|bin1 = 0b11010110
bin2 = 0b1_0_1

oct1 = 0o01234567
oct2 = 0o755
oct3 = 0o7_6_5

hex1 = 0xDEADBEEF
hex2 = 0xdeadbeef
hex3 = 0xdead_beef
hex4 = 0x00987
|);

is($actual, $expected1, 'integer/literals - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'integer/literals - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'integer/literals - to_toml') or do{
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