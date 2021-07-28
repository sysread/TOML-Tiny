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
               'backslash' => 'This string has a \\\\ backslash character.',
               'backspace' => 'This string has a \\b backspace character.',
               'carriage' => 'This string has a \\r carriage return character.',
               'formfeed' => 'This string has a \\f form feed character.',
               'newline' => 'This string has a \\n new line character.',
               'slash' => 'This string has a \\/ slash character.',
               'tab' => 'This string has a \\t tab character.'
             };


my $actual = from_toml(q|backspace = 'This string has a \\b backspace character.'
tab = 'This string has a \\t tab character.'
newline = 'This string has a \\n new line character.'
formfeed = 'This string has a \\f form feed character.'
carriage = 'This string has a \\r carriage return character.'
slash = 'This string has a \\/ slash character.'
backslash = 'This string has a \\\\ backslash character.'
|);

is($actual, $expected1, 'string/raw - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

is(eval{ scalar from_toml(to_toml($actual)) }, $expected1, 'string/raw - to_toml') or do{
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