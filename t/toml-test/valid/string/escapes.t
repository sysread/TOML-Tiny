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
               'backslash' => 'This string has a \\ backslash character.',
               'backspace' => 'This string has a  backspace character.',
               'carriage' => 'This string has a  carriage return character.',
               'delete' => 'This string has a  delete control code.',
               'formfeed' => 'This string has a  form feed character.',
               'newline' => 'This string has a 
 new line character.',
               'notunicode1' => 'This string does not have a unicode \\u escape.',
               'notunicode2' => 'This string does not have a unicode \\u escape.',
               'notunicode3' => 'This string does not have a unicode \\u0075 escape.',
               'notunicode4' => 'This string does not have a unicode \\u escape.',
               'quote' => 'This string has a " quote character.',
               'tab' => 'This string has a 	 tab character.',
               'unitseparator' => 'This string has a  unit separator control code.'
             };


my $actual = from_toml(q|backspace = "This string has a \\b backspace character."
tab = "This string has a \\t tab character."
newline = "This string has a \\n new line character."
formfeed = "This string has a \\f form feed character."
carriage = "This string has a \\r carriage return character."
quote = "This string has a \\" quote character."
backslash = "This string has a \\\\ backslash character."
notunicode1 = "This string does not have a unicode \\\\u escape."
notunicode2 = "This string does not have a unicode \\u005Cu escape."
notunicode3 = "This string does not have a unicode \\\\u0075 escape."
notunicode4 = "This string does not have a unicode \\\\\\u0075 escape."
delete = "This string has a \\u007F delete control code."
unitseparator = "This string has a \\u001F unit separator control code."
|);

is($actual, $expected1, 'string/escapes - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'string/escapes - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'string/escapes - to_toml') or do{
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