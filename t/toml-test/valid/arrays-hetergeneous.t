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
               'mixed' => [
                            [
                              bless( {
                                       '_file' => '(eval 310)',
                                       'code' => sub {
                                                     BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                     use strict;
                                                     no feature ':all';
                                                     use feature ':5.16';
                                                     require Math::BigInt;
                                                     'Math::BigInt'->new('1')->beq($_);
                                                 },
                                       'name' => '<Custom Code>',
                                       '_lines' => [
                                                     6
                                                   ],
                                       'operator' => 'CODE(...)'
                                     }, 'Test2::Compare::Custom' ),
                              bless( {
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
                                                     require Math::BigInt;
                                                     'Math::BigInt'->new('2')->beq($_);
                                                 },
                                       '_file' => '(eval 311)'
                                     }, 'Test2::Compare::Custom' )
                            ],
                            [
                              'a',
                              'b'
                            ],
                            [
                              bless( {
                                       '_file' => '(eval 312)',
                                       'code' => sub {
                                                     BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                     use strict;
                                                     no feature ':all';
                                                     use feature ':5.16';
                                                     require Math::BigFloat;
                                                     'Math::BigFloat'->new('1.1')->beq($_);
                                                 },
                                       'name' => '<Custom Code>',
                                       '_lines' => [
                                                     6
                                                   ],
                                       'operator' => 'CODE(...)'
                                     }, 'Test2::Compare::Custom' ),
                              bless( {
                                       'operator' => 'CODE(...)',
                                       '_lines' => [
                                                     6
                                                   ],
                                       'name' => '<Custom Code>',
                                       '_file' => '(eval 313)',
                                       'code' => sub {
                                                     BEGIN {${^WARNING_BITS} = "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x00\x04\x40\x05\x04\x50"}
                                                     use strict;
                                                     no feature ':all';
                                                     use feature ':5.16';
                                                     require Math::BigFloat;
                                                     'Math::BigFloat'->new('2.1')->beq($_);
                                                 }
                                     }, 'Test2::Compare::Custom' )
                            ]
                          ]
             };


my $actual = from_toml(q{mixed = [[1, 2], ["a", "b"], [1.1, 2.1]]
});

is($actual, $expected1, 'arrays-hetergeneous - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $actual, 'arrays-hetergeneous - to_toml') or do{
  diag 'INPUT:';
  diag Dumper($actual);

  diag '';
  diag 'TOML OUTPUT:';
  diag to_toml($actual);

  diag '';
  diag 'REPARSED OUTPUT:';
  diag Dumper(scalar from_toml(to_toml($actual)));
};

done_testing;