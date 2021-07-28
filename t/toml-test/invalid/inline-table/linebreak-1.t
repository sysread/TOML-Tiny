# File automatically generated from BurntSushi/toml-test
use utf8;
use Test2::V0;
use TOML::Tiny;

binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

ok dies(sub{
  from_toml(q|
# No newlines are allowed between the curly braces unless they are valid within
# a value.
simple = { a = 1 
}

  |, strict => 1);
}), 'strict_mode dies on inline-table/linebreak-1';

done_testing;