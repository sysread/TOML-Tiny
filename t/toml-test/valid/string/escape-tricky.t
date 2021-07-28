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
               'end_esc' => 'String does not end here" but ends here\\',
               'lit_end_esc' => 'String ends here\\',
               'lit_multiline_end' => 'There is no escape\\',
               'lit_multiline_not_unicode' => '\\u007f',
               'multiline_end_esc' => 'When will it end? """...""" should be here"',
               'multiline_not_unicode' => '\\u0041',
               'multiline_unicode' => "\x{a0}"
             };


my $actual = from_toml(q|end_esc = "String does not end here\\" but ends here\\\\"
lit_end_esc = 'String ends here\\'

multiline_unicode = """
\\u00a0"""

multiline_not_unicode = """
\\\\u0041"""

multiline_end_esc = """When will it end? \\"""...""\\" should be here\\""""

lit_multiline_not_unicode = '''
\\u007f'''

lit_multiline_end = '''There is no escape\\'''
|);

is($actual, $expected1, 'string/escape-tricky - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $expected1, 'string/escape-tricky - to_toml') or do{
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