# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

ok dies(sub{
  from_toml(q|
a = "\\UFFFFFFFF"

  |, strict => 1);
}), 'strict_mode dies on string/basic-out-of-range-unicode-escape-1';

done_testing;