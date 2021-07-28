# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

ok dies(sub{
  from_toml(q|
exp-point-1 = 1e2.3

  |, strict => 1);
}), 'strict_mode dies on float/exp-point-1';

done_testing;