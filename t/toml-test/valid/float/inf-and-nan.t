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
               'infinity' => bless( {
                                      '_file' => '(eval 402)',
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
                                                    'Math::BigFloat'->new('inf')->beq($got);
                                                },
                                      'name' => 'Math::BigFloat->new("inf")->beq($_)',
                                      'operator' => 'CODE(...)'
                                    }, 'Test2::Compare::Custom' ),
               'infinity_neg' => bless( {
                                          '_file' => '(eval 400)',
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
                                                        'Math::BigFloat'->new('-inf')->beq($got);
                                                    },
                                          'name' => 'Math::BigFloat->new("-inf")->beq($_)',
                                          'operator' => 'CODE(...)'
                                        }, 'Test2::Compare::Custom' ),
               'infinity_plus' => bless( {
                                           '_file' => '(eval 403)',
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
                                                         'Math::BigFloat'->new('+inf')->beq($got);
                                                     },
                                           'name' => 'Math::BigFloat->new("+inf")->beq($_)',
                                           'operator' => 'CODE(...)'
                                         }, 'Test2::Compare::Custom' ),
               'nan' => bless( {
                                 '_file' => '(eval 404)',
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
                                               'Math::BigFloat'->new('nan')->beq($got);
                                           },
                                 'name' => 'Math::BigFloat->new("nan")->beq($_)',
                                 'operator' => 'CODE(...)'
                               }, 'Test2::Compare::Custom' ),
               'nan_neg' => bless( {
                                     '_file' => '(eval 401)',
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
                                                   'Math::BigFloat'->new('nan')->beq($got);
                                               },
                                     'name' => 'Math::BigFloat->new("nan")->beq($_)',
                                     'operator' => 'CODE(...)'
                                   }, 'Test2::Compare::Custom' ),
               'nan_plus' => bless( {
                                      '_file' => '(eval 399)',
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
                                                    'Math::BigFloat'->new('nan')->beq($got);
                                                },
                                      'name' => 'Math::BigFloat->new("nan")->beq($_)',
                                      'operator' => 'CODE(...)'
                                    }, 'Test2::Compare::Custom' )
             };


my $actual = from_toml(q|# We don't encode +nan and -nan back with the signs; many languages don't
# support a sign on NaN (it doesn't really make much sense).
nan = nan
nan_neg = -nan
nan_plus = +nan
infinity = inf
infinity_neg = -inf
infinity_plus = +inf
|);

is($actual, $expected1, 'float/inf-and-nan - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $expected1, 'float/inf-and-nan - to_toml') or do{
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