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
               'a' => {
                        'a' => {
                                 'b' => bless( {
                                                 '_file' => '(eval 444)',
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
                                                               'Math::BigInt'->new('1')->beq($got);
                                                           },
                                                 'name' => 'Math::BigInt->new("1")->beq($_)',
                                                 'operator' => 'CODE(...)'
                                               }, 'Test2::Compare::Custom' )
                               }
                      },
               'arr' => [
                          {
                            'T' => {
                                     'a' => {
                                              'b' => bless( {
                                                              '_file' => '(eval 437)',
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
                                                                            'Math::BigInt'->new('1')->beq($got);
                                                                        },
                                                              'name' => 'Math::BigInt->new("1")->beq($_)',
                                                              'operator' => 'CODE(...)'
                                                            }, 'Test2::Compare::Custom' )
                                            }
                                   },
                            't' => {
                                     'a' => {
                                              'b' => bless( {
                                                              '_file' => '(eval 436)',
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
                                                                            'Math::BigInt'->new('1')->beq($got);
                                                                        },
                                                              'name' => 'Math::BigInt->new("1")->beq($_)',
                                                              'operator' => 'CODE(...)'
                                                            }, 'Test2::Compare::Custom' )
                                            }
                                   }
                          },
                          {
                            'T' => {
                                     'a' => {
                                              'b' => bless( {
                                                              '_file' => '(eval 439)',
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
                                                                            'Math::BigInt'->new('2')->beq($got);
                                                                        },
                                                              'name' => 'Math::BigInt->new("2")->beq($_)',
                                                              'operator' => 'CODE(...)'
                                                            }, 'Test2::Compare::Custom' )
                                            }
                                   },
                            't' => {
                                     'a' => {
                                              'b' => bless( {
                                                              '_file' => '(eval 438)',
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
                                                                            'Math::BigInt'->new('2')->beq($got);
                                                                        },
                                                              'name' => 'Math::BigInt->new("2")->beq($_)',
                                                              'operator' => 'CODE(...)'
                                                            }, 'Test2::Compare::Custom' )
                                            }
                                   }
                          }
                        ],
               'b' => {
                        'a' => {
                                 'b' => bless( {
                                                 '_file' => '(eval 433)',
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
                                                               'Math::BigInt'->new('1')->beq($got);
                                                           },
                                                 'name' => 'Math::BigInt->new("1")->beq($_)',
                                                 'operator' => 'CODE(...)'
                                               }, 'Test2::Compare::Custom' )
                               }
                      },
               'c' => {
                        'a' => {
                                 'b' => bless( {
                                                 '_file' => '(eval 440)',
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
                                                               'Math::BigInt'->new('1')->beq($got);
                                                           },
                                                 'name' => 'Math::BigInt->new("1")->beq($_)',
                                                 'operator' => 'CODE(...)'
                                               }, 'Test2::Compare::Custom' )
                               }
                      },
               'd' => {
                        'a' => {
                                 'b' => bless( {
                                                 '_file' => '(eval 446)',
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
                                                               'Math::BigInt'->new('1')->beq($got);
                                                           },
                                                 'name' => 'Math::BigInt->new("1")->beq($_)',
                                                 'operator' => 'CODE(...)'
                                               }, 'Test2::Compare::Custom' )
                               }
                      },
               'e' => {
                        'a' => {
                                 'b' => bless( {
                                                 '_file' => '(eval 445)',
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
                                                               'Math::BigInt'->new('1')->beq($got);
                                                           },
                                                 'name' => 'Math::BigInt->new("1")->beq($_)',
                                                 'operator' => 'CODE(...)'
                                               }, 'Test2::Compare::Custom' )
                               }
                      },
               'inline' => {
                             'a' => {
                                      'b' => bless( {
                                                      '_file' => '(eval 441)',
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
                                                    }, 'Test2::Compare::Custom' )
                                    }
                           },
               'many' => {
                           'dots' => {
                                       'here' => {
                                                   'dot' => {
                                                              'dot' => {
                                                                         'dot' => {
                                                                                    'a' => {
                                                                                             'b' => {
                                                                                                      'c' => bless( {
                                                                                                                      '_file' => '(eval 434)',
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
                                                                                                                                    'Math::BigInt'->new('1')->beq($got);
                                                                                                                                },
                                                                                                                      'name' => 'Math::BigInt->new("1")->beq($_)',
                                                                                                                      'operator' => 'CODE(...)'
                                                                                                                    }, 'Test2::Compare::Custom' ),
                                                                                                      'd' => bless( {
                                                                                                                      '_file' => '(eval 435)',
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
                                                                                                                                    'Math::BigInt'->new('2')->beq($got);
                                                                                                                                },
                                                                                                                      'name' => 'Math::BigInt->new("2")->beq($_)',
                                                                                                                      'operator' => 'CODE(...)'
                                                                                                                    }, 'Test2::Compare::Custom' )
                                                                                                    }
                                                                                           }
                                                                                  }
                                                                       }
                                                            }
                                                 }
                                     }
                         },
               'tbl' => {
                          'a' => {
                                   'b' => {
                                            'c' => {
                                                     'd' => {
                                                              'e' => bless( {
                                                                              '_file' => '(eval 442)',
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
                                                                                            'Math::BigInt'->new('1')->beq($got);
                                                                                        },
                                                                              'name' => 'Math::BigInt->new("1")->beq($_)',
                                                                              'operator' => 'CODE(...)'
                                                                            }, 'Test2::Compare::Custom' )
                                                            }
                                                   }
                                          }
                                 },
                          'x' => {
                                   'a' => {
                                            'b' => {
                                                     'c' => {
                                                              'd' => {
                                                                       'e' => bless( {
                                                                                       '_file' => '(eval 443)',
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
                                                                                                     'Math::BigInt'->new('1')->beq($got);
                                                                                                 },
                                                                                       'name' => 'Math::BigInt->new("1")->beq($_)',
                                                                                       'operator' => 'CODE(...)'
                                                                                     }, 'Test2::Compare::Custom' )
                                                                     }
                                                            }
                                                   }
                                          }
                                 }
                        }
             };


my $actual = from_toml(q|inline = {a.b = 42}

many.dots.here.dot.dot.dot = {a.b.c = 1, a.b.d = 2}

a = {   a.b  =  1   }
b = {   "a"."b"  =  1   }
c = {   a   .   b  =  1   }
d = {   'a'   .   "b"  =  1   }
e = {a.b=1}

[tbl]
a.b.c = {d.e=1}

[tbl.x]
a.b.c = {d.e=1}

[[arr]]
t = {a.b=1}
T = {a.b=1}

[[arr]]
t = {a.b=2}
T = {a.b=2}
|);

is($actual, $expected1, 'inline-table/key-dotted - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'inline-table/key-dotted - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'inline-table/key-dotted - to_toml') or do{
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