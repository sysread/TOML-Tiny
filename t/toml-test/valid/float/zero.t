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
               'f1' => bless( {
                                '_file' => '(eval 191)',
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
                                              'Math::BigFloat'->new('0')->beq($got);
                                          },
                                'name' => 'Math::BigFloat->new("0")->beq($_)',
                                'operator' => 'CODE(...)'
                              }, 'Test2::Compare::Custom' ),
               'f2' => bless( {
                                '_file' => '(eval 193)',
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
                                              'Math::BigFloat'->new('0')->beq($got);
                                          },
                                'name' => 'Math::BigFloat->new("0")->beq($_)',
                                'operator' => 'CODE(...)'
                              }, 'Test2::Compare::Custom' ),
               'f3' => bless( {
                                '_file' => '(eval 195)',
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
                                              'Math::BigFloat'->new('0')->beq($got);
                                          },
                                'name' => 'Math::BigFloat->new("0")->beq($_)',
                                'operator' => 'CODE(...)'
                              }, 'Test2::Compare::Custom' ),
               'f4' => bless( {
                                '_file' => '(eval 190)',
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
                                              'Math::BigFloat'->new('0')->beq($got);
                                          },
                                'name' => 'Math::BigFloat->new("0")->beq($_)',
                                'operator' => 'CODE(...)'
                              }, 'Test2::Compare::Custom' ),
               'f5' => bless( {
                                '_file' => '(eval 192)',
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
                                              'Math::BigFloat'->new('0')->beq($got);
                                          },
                                'name' => 'Math::BigFloat->new("0")->beq($_)',
                                'operator' => 'CODE(...)'
                              }, 'Test2::Compare::Custom' ),
               'f6' => bless( {
                                '_file' => '(eval 196)',
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
                                              'Math::BigFloat'->new('0')->beq($got);
                                          },
                                'name' => 'Math::BigFloat->new("0")->beq($_)',
                                'operator' => 'CODE(...)'
                              }, 'Test2::Compare::Custom' ),
               'f7' => bless( {
                                '_file' => '(eval 194)',
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
                                              'Math::BigFloat'->new('0')->beq($got);
                                          },
                                'name' => 'Math::BigFloat->new("0")->beq($_)',
                                'operator' => 'CODE(...)'
                              }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml(q|f1 = 0.0
f2 = +0.0
f3 = -0.0
f4 = 0e0
f5 = 0e00
f6 = +0e0
f7 = -0e0
|);

is($actual, $expected1, 'float/zero - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'float/zero - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'float/zero - to_toml') or do{
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