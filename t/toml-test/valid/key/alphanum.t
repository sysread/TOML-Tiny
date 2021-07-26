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
               '000111' => 'leading',
               '10e3' => 'false float',
               '123' => 'num',
               '2018_10' => {
                              '001' => bless( {
                                                '_file' => '(eval 482)',
                                                '_lines' => [
                                                              7
                                                            ],
                                                'code' => sub {
                                                              BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x40"}
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
               '34-11' => bless( {
                                   '_file' => '(eval 481)',
                                   '_lines' => [
                                                 7
                                               ],
                                   'code' => sub {
                                                 BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x40"}
                                                 use strict;
                                                 no feature ':all';
                                                 use feature ':5.16';
                                                 require Math::BigInt;
                                                 my $got = 'Math::BigInt'->new($_);
                                                 'Math::BigInt'->new('23')->beq($got);
                                             },
                                   'name' => 'Math::BigInt->new("23")->beq($_)',
                                   'operator' => 'CODE(...)'
                                 }, 'Test2::Compare::Custom' ),
               'a-a-a' => {
                            '_' => 0
                          },
               'alpha' => 'a',
               'one1two2' => 'mixed',
               'under_score' => '___',
               'with-dash' => 'dashed'
             };


my $actual = from_toml(q|alpha = "a"
123 = "num"
000111 = "leading"
10e3 = "false float"
one1two2 = "mixed"
with-dash = "dashed"
under_score = "___"
34-11 = 23

[2018_10]
001 = 1

[a-a-a]
_ = false
|);

is($actual, $expected1, 'key/alphanum - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $expected1, 'key/alphanum - to_toml') or do{
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