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
               'group' => {
                            'answer' => bless( {
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
                                                               'Math::BigInt'->new('42')->beq($_);
                                                           },
                                                 'operator' => 'CODE(...)',
                                                 '_file' => '(eval 314)'
                                               }, 'Test2::Compare::Custom' ),
                            'more' => [
                                        bless( {
                                                 'name' => '<Custom Code>',
                                                 '_lines' => [
                                                               6
                                                             ],
                                                 'code' => sub {
                                                               BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                               use strict;
                                                               no feature ':all';
                                                               use feature ':5.16';
                                                               require Math::BigInt;
                                                               'Math::BigInt'->new('42')->beq($_);
                                                           },
                                                 '_file' => '(eval 315)',
                                                 'operator' => 'CODE(...)'
                                               }, 'Test2::Compare::Custom' ),
                                        bless( {
                                                 'operator' => 'CODE(...)',
                                                 '_file' => '(eval 316)',
                                                 'code' => sub {
                                                               BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                               use strict;
                                                               no feature ':all';
                                                               use feature ':5.16';
                                                               require Math::BigInt;
                                                               'Math::BigInt'->new('42')->beq($_);
                                                           },
                                                 '_lines' => [
                                                               6
                                                             ],
                                                 'name' => '<Custom Code>'
                                               }, 'Test2::Compare::Custom' )
                                      ]
                          }
             };


my $actual = from_toml(q{# Top comment.
  # Top comment.
# Top comment.

# [no-extraneous-groups-please]

[group] # Comment
answer = 42 # Comment
# no-extraneous-keys-please = 999
# Inbetween comment.
more = [ # Comment
  # What about multiple # comments?
  # Can you handle it?
  #
          # Evil.
# Evil.
  42, 42, # Comments within arrays are fun.
  # What about multiple # comments?
  # Can you handle it?
  #
          # Evil.
# Evil.
# ] Did I fool you?
] # Hopefully not.
});

is($actual, $expected1, 'comments-everywhere - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ from_toml(to_toml($actual)) }, $actual, 'comments-everywhere - to_toml') or do{
  diag 'INPUT:';
  diag Dumper($actual);

  diag 'TOML OUTPUT:';
  diag to_toml($actual);

  diag 'REPARSED OUTPUT:';
  diag Dumper(from_toml(to_toml($actual)));
};

done_testing;