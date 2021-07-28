# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

ok dies(sub{
  from_toml(q|
t = {x = 3 y = 4}

  |, strict => 1);
}), 'strict_mode dies on inline-table/no-comma';

done_testing;