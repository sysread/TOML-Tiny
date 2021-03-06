# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

ok dies(sub{
  from_toml(q{
[fruit]
type = "apple"

[fruit.type]
apple = "yes"

  }, strict_arrays => 1);
}), 'strict_mode dies on duplicate-key-table';

done_testing;