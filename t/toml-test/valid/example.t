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
               'best-day-ever' => bless( {
                                           '_file' => '(eval 386)',
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
               'numtheory' => {
                                'boring' => 0,
                                'perfection' => [
                                                  bless( {
                                                           '_file' => '(eval 387)',
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
                                                                         'Math::BigInt'->new('6')->beq($got);
                                                                     },
                                                           'name' => 'Math::BigInt->new("6")->beq($_)',
                                                           'operator' => 'CODE(...)'
                                                         }, 'Test2::Compare::Custom' ),
                                                  bless( {
                                                           '_file' => '(eval 388)',
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
                                                                         'Math::BigInt'->new('28')->beq($got);
                                                                     },
                                                           'name' => 'Math::BigInt->new("28")->beq($_)',
                                                           'operator' => 'CODE(...)'
                                                         }, 'Test2::Compare::Custom' ),
                                                  bless( {
                                                           '_file' => '(eval 389)',
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
                                                                         'Math::BigInt'->new('496')->beq($got);
                                                                     },
                                                           'name' => 'Math::BigInt->new("496")->beq($_)',
                                                           'operator' => 'CODE(...)'
                                                         }, 'Test2::Compare::Custom' )
                                                ]
                              }
             };


my $actual = from_toml(q|best-day-ever = 1987-07-05T17:45:00Z

[numtheory]
boring = false
perfection = [6, 28, 496]
|);

is($actual, $expected1, 'example - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

is($error, U, 'example - to_toml - no errors');

is($reparsed, $expected1, 'example - to_toml') or do{
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