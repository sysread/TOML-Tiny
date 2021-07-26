# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

ok dies(sub{
  from_toml(q|
# Define b as int, and try to use it as a table: error
[a]
b = 1

[a.b]
c = 2

  |, strict_arrays => 1);
}), 'strict_mode dies on table/redefine';

done_testing;