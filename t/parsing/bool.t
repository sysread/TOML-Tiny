use Test2::V0;
use TOML::Tiny;

is from_toml('x=true'), {x => $TOML::Tiny::Parser::TRUE}, 'true';
is from_toml('x=false'), {x => $TOML::Tiny::Parser::FALSE}, 'false';
is from_toml('x=true', inflate_boolean => sub{ $_[0] eq 'true' ? 'T' : 'F' }), {x => 'T'}, 'inflate_boolean(true)';
is from_toml('x=false', inflate_boolean => sub{ $_[0] eq 'true' ? 'T' : 'F' }), {x => 'F'}, 'inflate_boolean(false)';

done_testing;
