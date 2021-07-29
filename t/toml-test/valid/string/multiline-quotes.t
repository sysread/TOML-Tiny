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
               'lit_one' => '\'one quote\'',
               'lit_one_space' => ' \'one quote\' ',
               'lit_two' => '\'\'two quotes\'\'',
               'lit_two_space' => ' \'\'two quotes\'\' ',
               'mismatch1' => 'aaa\'\'\'bbb',
               'mismatch2' => 'aaa"""bbb',
               'one' => '"one quote"',
               'one_space' => ' "one quote" ',
               'two' => '""two quotes""',
               'two_space' => ' ""two quotes"" '
             };


my $actual = from_toml(q|# Make sure that quotes inside multiline strings are allowed, including right
# after the opening '''/""" and before the closing '''/"""

lit_one = ''''one quote''''
lit_two = '''''two quotes'''''
lit_one_space = ''' 'one quote' '''
lit_two_space = ''' ''two quotes'' '''

one = """"one quote""""
two = """""two quotes"""""
one_space = """ "one quote" """
two_space = """ ""two quotes"" """

mismatch1 = """aaa'''bbb"""
mismatch2 = '''aaa"""bbb'''
|);

is($actual, $expected1, 'string/multiline-quotes - from_toml') or do{
  diag 'EXPECTED:';
  diag Dumper($expected1);

  diag '';
  diag 'ACTUAL:';
  diag Dumper($actual);
};

my $regenerated = to_toml $actual;
my $reparsed    = eval{ scalar from_toml $regenerated };
my $error       = $@;

ok(!$error, 'string/multiline-quotes - to_toml - no errors')
  or diag $error;

is($reparsed, $expected1, 'string/multiline-quotes - to_toml') or do{
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