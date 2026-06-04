use strict;
use warnings;

use Test2::V0;
use TOML::Tiny qw(from_toml);
use TOML::Tiny::Parser;
use TOML::Tiny::Tokenizer;

#-------------------------------------------------------------------------------
# max_depth is interpolated into regex quantifiers ({0,N} / {N}) built in the
# tokenizer. A negative or non-integer value produces a MALFORMED regex: Perl
# emits "Unescaped left brace in regex is passed through" warnings and treats
# the quantifier as literal text, so the key regexes silently stop matching and
# every document fails with a misleading "exceeded maximum nesting depth" error.
#
# An invalid max_depth is a usage error, not a parse error, so it must die
# loudly and clearly (referencing max_depth) at construction -- not produce
# regex warnings and bogus parse failures.
#-------------------------------------------------------------------------------

my @invalid = (
  [ 'negative integer'      => -5    ],
  [ 'negative one'          => -1    ],
  [ 'fractional'            => 1.5   ],
  [ 'non-numeric string'    => 'abc' ],
  [ 'empty string'          => ''    ],
);

for my $case (@invalid) {
  my ($desc, $value) = @$case;

  my @warnings;
  local $SIG{__WARN__} = sub { push @warnings, $_[0] };

  my $err = dies { TOML::Tiny::Parser->new(max_depth => $value) };
  like($err, qr/max_depth/, "Parser->new rejects $desc max_depth with a clear message");

  $err = dies { TOML::Tiny::Tokenizer->new(source => 'a = 1', max_depth => $value) };
  like($err, qr/max_depth/, "Tokenizer->new rejects $desc max_depth with a clear message");

  $err = dies { from_toml('a = 1', max_depth => $value) };
  like($err, qr/max_depth/, "from_toml rejects $desc max_depth with a clear message");

  is(\@warnings, [], "$desc max_depth produces no regex warnings");
}

# Valid values keep working: a non-negative integer parses normally.
{
  my ($data, $err) = from_toml('a.b.c.d = 1', max_depth => 16);
  ok(!$err, 'valid max_depth parses a dotted key') or diag $err;
  is($data, { a => { b => { c => { d => 1 } } } }, 'parsed structure is correct');
}

done_testing;
