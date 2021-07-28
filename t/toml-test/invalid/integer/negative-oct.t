# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

ok dies(sub{
  from_toml(q|
negative-oct = -0o99

  |, strict => 1);
}), 'strict_mode dies on integer/negative-oct';

done_testing;