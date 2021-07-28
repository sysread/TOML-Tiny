# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

ok dies(sub{
  from_toml(q|
�� #   U T F - 1 6   w i t h   B O M 

  |, strict => 1);
}), 'strict_mode dies on encoding/utf16-bom';

done_testing;