# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

ok dies(sub{
  from_toml(q|
# There is a 0xda at after the quotes, and no EOL at the end of the file.
#
# This is a bit of an edge case: This indicates there should be two bytes
# (0b1101_1010) but there is no byte to follow because it's the end of the file.
x = """"""Ú
  |, strict_arrays => 1);
}), 'strict_mode dies on encoding/bad-utf8-at-end';

done_testing;