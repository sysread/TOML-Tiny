use Test2::V0;
use TOML::Tiny;

is from_toml(q{x="how now brown bureaucrat"}), {x => "how now brown bureaucrat"}, 'basic string';
is from_toml(q{x=""}), {x => ''}, 'empty string';
is from_toml(q{x="\\\\n"}), {x => q{\n}}, 'escaped escape';

is from_toml(q{backspace   = "This string has a \b backspace character."}),             {backspace   => "This string has a \b backspace character."}, 'backspace';
is from_toml(q{tab         = "This string has a \t tab character."}),                   {tab         => "This string has a \t tab character."}, 'tab';
is from_toml(q{newline     = "This string has a \n new line character."}),              {newline     => "This string has a \n new line character."}, 'newline';
is from_toml(q{formfeed    = "This string has a \f form feed character."}),             {formfeed    => "This string has a \f form feed character."}, 'formfeed';
is from_toml(q{carriage    = "This string has a \r carriage return character."}),       {carriage    => "This string has a \r carriage return character."}, 'carriage';
is from_toml(q{quote       = "This string has a \" quote character."}),                 {quote       => "This string has a \" quote character."}, 'quote';
is from_toml(q{backslash   = "This string has a \\\\ backslash character."}),           {backslash   => "This string has a \\ backslash character."}, 'backslash';

is from_toml(q{notunicode1 = "This string does not have a unicode \\\\u escape."}),     {notunicode1 => "This string does not have a unicode \\u escape."}, 'not unicode 1';
is from_toml(q{notunicode2 = "This string does not have a unicode \u005Cu escape."}),   {notunicode2 => "This string does not have a unicode \\u escape."}, 'not unicode 2';
is from_toml(q{notunicode3 = "This string does not have a unicode \\\\u0075 escape."}), {notunicode3 => "This string does not have a unicode \\u0075 escape."}, 'not unicode 3';
is from_toml(q{notunicode4 = "This string does not have a unicode \\\u0075 escape."}),  {notunicode4 => "This string does not have a unicode \\u0075 escape."}, 'not unicode 4';

is from_toml(q{nl_mid = "val\nue"}),     {nl_mid => "val\nue"}, 'newline in middle of string';
is from_toml(q{nl_end = """value\n"""}), {nl_end => "value\n"}, 'newline at end of string';

is from_toml(q{lit_nl_end = '''value\n'''}), {lit_nl_end => 'value\n'}, 'literal with \n at end';
is from_toml(q{lit_nl_mid = 'val\nue'}),     {lit_nl_mid => 'val\nue'}, 'literal with \n in middle';
is from_toml(q{lit_nl_uni = 'val\ue'}),      {lit_nl_uni => 'val\ue'},  'literal with \u in middle';

is from_toml(q{x="hash in # string"}), {x => 'hash in # string'}, 'hash inside string is not recognized as comment';
is from_toml(q{x="hash in # string" # comment after}), {x => 'hash in # string'}, 'hash in string with comment after string parsed correctly';

done_testing;
