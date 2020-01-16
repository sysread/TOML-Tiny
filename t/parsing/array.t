use Test2::V0;
use TOML::Tiny;

is from_toml('thevoid=[[[]]]'), {thevoid => [[[]]]}, 'empty';

is from_toml('ints=[1,2,3]'), {ints => [1, 2, 3]}, 'no spaces';

is from_toml('ints=[1, 2, 3] # comment'), {ints => [1, 2, 3]}, 'comments after array';

is from_toml(q{

ints=[
  1,      # comments
  2, 3
]

}), {ints => [1, 2, 3]}, 'multi-line, w/ comments';

is from_toml('ints=[1, 2, 3, ]'), {ints => [1, 2, 3]}, 'trailing comma';

is from_toml('nested=[["a"], ["b", ["c"]]]'), {nested => [['a'], ['b', ['c']]]}, 'nested';

is from_toml(q{
title = [
  "Client: \"XXXX\", Job: XXXX",
  "Code: XXXX"
]
}), {title => ['Client: "XXXX", Job: XXXX', 'Code: XXXX']}, 'with string containing comma';;

is from_toml(q{title = [ " \", ",]}), {title => [' ", ']}, 'with string containing escaped quote, then comma';

is from_toml(q|foo = [ { bar="\"{{baz}}\""} ]|), {foo => [{bar => '"{{baz}}"'}]}, 'escaped quotes in string in table array table';

done_testing;
