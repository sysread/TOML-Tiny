# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

ok dies(sub{
  from_toml(q|
no-leads = 1987-7-05T17:45:00Z

  |, strict => 1);
}), 'strict_mode dies on datetime/no-leads';

done_testing;