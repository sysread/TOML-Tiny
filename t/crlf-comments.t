use strict;
use warnings;

use Test2::V0;
use TOML::Tiny qw(from_toml);

#-------------------------------------------------------------------------------
# The linear-EOL tokenizer fix changed HOW a comment followed by a line
# terminator is consumed: bare $Comment now stops at the CR/LF and the
# terminator is matched separately by $CRLF (\x0D?\x0A). These cases assert the
# resulting parse is unchanged across LF- and CRLF-terminated comments, and
# that a comment at EOF (no trailing newline) still parses. The BurntSushi
# suite has no CRLF-with-comment fixture, so guard it explicitly here.
#-------------------------------------------------------------------------------

my %cases = (
  'LF, comment after value'        => qq{key = "value" # comment\n},
  'CRLF, comment after value'      => qq{key = "value" # comment\r\n},
  'LF, full-line comment then kv'  => qq{# heading\nkey = "value"\n},
  'CRLF, full-line comment then kv' => qq{# heading\r\nkey = "value"\r\n},
  'CRLF, comment at EOF, no newline' => qq{key = "value"\r\n# trailing comment},
  'LF, comment at EOF, no newline'   => qq{key = "value"\n# trailing comment},
);

for my $name (sort keys %cases) {
  my ($data, $err) = from_toml($cases{$name});
  ok(!$err, "$name: parses without error") or diag($err);
  is($data, {key => 'value'}, "$name: yields expected data");
}

done_testing;
