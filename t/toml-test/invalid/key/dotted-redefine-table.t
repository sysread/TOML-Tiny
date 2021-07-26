# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

ok dies(sub{
  from_toml(q|
# Defined a.b as int
a.b = 1
# Tries to access it as table: error
a.b.c = 2

  |, strict_arrays => 1);
}), 'strict_mode dies on key/dotted-redefine-table';

done_testing;