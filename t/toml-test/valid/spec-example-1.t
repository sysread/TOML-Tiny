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
               'clients' => {
                              'data' => [
                                          [
                                            'gamma',
                                            'delta'
                                          ],
                                          [
                                            bless( {
                                                     '_file' => '(eval 298)',
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
                                            bless( {
                                                     '_file' => '(eval 299)',
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
                                          ]
                                        ],
                              'hosts' => [
                                           'alpha',
                                           'omega'
                                         ]
                            },
               'database' => {
                               'connection_max' => bless( {
                                                            '_file' => '(eval 297)',
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
                                                                          'Math::BigInt'->new('5000')->beq($got);
                                                                      },
                                                            'name' => 'Math::BigInt->new("5000")->beq($_)',
                                                            'operator' => 'CODE(...)'
                                                          }, 'Test2::Compare::Custom' ),
                               'enabled' => 1,
                               'ports' => [
                                            bless( {
                                                     '_file' => '(eval 294)',
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
                                                                   'Math::BigInt'->new('8001')->beq($got);
                                                               },
                                                     'name' => 'Math::BigInt->new("8001")->beq($_)',
                                                     'operator' => 'CODE(...)'
                                                   }, 'Test2::Compare::Custom' ),
                                            bless( {
                                                     '_file' => '(eval 295)',
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
                                                                   'Math::BigInt'->new('8001')->beq($got);
                                                               },
                                                     'name' => 'Math::BigInt->new("8001")->beq($_)',
                                                     'operator' => 'CODE(...)'
                                                   }, 'Test2::Compare::Custom' ),
                                            bless( {
                                                     '_file' => '(eval 296)',
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
                                                                   'Math::BigInt'->new('8002')->beq($got);
                                                               },
                                                     'name' => 'Math::BigInt->new("8002")->beq($_)',
                                                     'operator' => 'CODE(...)'
                                                   }, 'Test2::Compare::Custom' )
                                          ],
                               'server' => '192.168.1.1'
                             },
               'owner' => {
                            'dob' => '1979-05-27T07:32:00-08:00',
                            'name' => 'Lance Uppercut'
                          },
               'servers' => {
                              'alpha' => {
                                           'dc' => 'eqdc10',
                                           'ip' => '10.0.0.1'
                                         },
                              'beta' => {
                                          'dc' => 'eqdc10',
                                          'ip' => '10.0.0.2'
                                        }
                            },
               'title' => 'TOML Example'
             };


my $actual = from_toml(q|# This is a TOML document. Boom.

title = "TOML Example"

[owner]
name = "Lance Uppercut"
dob = 1979-05-27T07:32:00-08:00 # First class dates? Why not?

[database]
server = "192.168.1.1"
ports = [ 8001, 8001, 8002 ]
connection_max = 5000
enabled = true

[servers]

  # You can indent as you please. Tabs or spaces. TOML don't care.
  [servers.alpha]
  ip = "10.0.0.1"
  dc = "eqdc10"

  [servers.beta]
  ip = "10.0.0.2"
  dc = "eqdc10"

[clients]
data = [ ["gamma", "delta"], [1, 2] ]

# Line breaks are OK when inside arrays
hosts = [
  "alpha",
  "omega"
]
|);

is($actual, $expected1, 'spec-example-1 - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'spec-example-1 - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'spec-example-1 - to_toml') or do{
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