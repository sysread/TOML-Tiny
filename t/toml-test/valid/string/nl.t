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
               'lit_nl_end' => 'value\\n',
               'lit_nl_mid' => 'val\\nue',
               'lit_nl_uni' => 'val\\ue',
               'nl_end' => 'value
',
               'nl_mid' => 'val
ue'
             };


my $actual = from_toml(q|nl_mid = "val\\nue"
nl_end = """value\\n"""

lit_nl_end = '''value\\n'''
lit_nl_mid = 'val\\nue'
lit_nl_uni = 'val\\ue'
|);

is($actual, $expected1, 'string/nl - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'string/nl - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'string/nl - to_toml') or do{
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