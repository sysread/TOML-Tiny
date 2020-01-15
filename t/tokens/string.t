use Test2::V0;
use TOML::Tiny::Grammar;

sub test_simple_matches {
  my ($re, @tests) = @_;
  for (@tests) {
    my ($toml, $expected, $label) = @$_;
    my ($match) = $toml =~ $re;
    is $match, $expected, $label;
  }
}

subtest 'string group' => sub{
  use Regexp::Debugger;
  my $re = qr{ ((?&String)) $TOML }x;

  test_simple_matches($re,
    [q{"A"}, q{"A"}, 'basic string'],
    [q{'A'}, q{'A'}, 'string literal'],
    [q{"""A"""}, q{"""A"""}, 'multi-line string'],
    [q{'''A'''}, q{'''A'''}, 'multi-line string literal'],
  );
};

subtest 'escaped characters' => sub{
  my $re = qr{
    ((?&EscapeChar))
    $TOML
  }x;

  test_simple_matches($re,
    ['\\\\', '\\\\', 'slash'],
    ['\\b', '\\b', 'backspace'],
    ['\\t', '\\t', 'tab'],
    ['\\n', '\\n', 'line feed'],
    ['\\f', '\\f', 'form feed'],
    ['\\r', '\\r', 'carriage return'],
    ['\\"', '\\"', 'quote'],
    ['\\\\', '\\\\', 'backslash'],
    ['\\u1234', '\\u1234', 'unicode (4 bytes)'],
    ['\\U12345678', '\\U12345678', 'unicode (8 bytes)'],
    ['\\x', undef, 'invalid'],
  );
};

subtest 'string literals' => sub{
  my $re = qr{
    ((?&StringLiteral))
    $TOML
  }x;

  test_simple_matches($re,
    [q{'abc'}, q{'abc'}, 'single-quoted'],
    [q{''}, q{''}, 'empty single-quoted'],
  );
};

subtest 'basic strings' => sub{
  my $re = qr{
    ((?&BasicString))
    $TOML
  }x;

  test_simple_matches($re,
    ['""', '""', "empty string"],
    ['"abc"', '"abc"', 'simple'],
    ['"\\tfoo"', '"\\tfoo"', 'escaped chars'],
    ['1234', undef, 'invalid'],
  );
};

subtest 'multi-line strings' => sub{
  my $re = qr{
    ((?&MultiLineString))
    $TOML
  }x;

  test_simple_matches($re,
    [ qq{"""\nabc"""}, qq{"""\nabc"""}, 'simple' ],
    [ qq{""" " """}, q{""" " """}, 'containing 1 quote' ],
    [ qq{""" "" """}, q{""" "" """}, 'containing 2 quotes' ],
    [ qq{"""a\n"b"\nc"""}, qq{"""a\n"b"\nc"""}, 'individual quotes within ml string' ],
    [ qq{"""foo"""bar"""}, qq{"""foo"""}, 'invalid: triple-quotes appear within ml string' ],
  );
};

subtest 'multi-line string literals' => sub{
  my $re = qr{ ((?&MultiLineStringLiteral)) $TOML }x;

  test_simple_matches($re,
    [ qq{'''\nabc'''}, qq{'''\nabc'''}, 'simple' ],
    [ qq{''' ' '''}, q{''' ' '''}, 'containing 1 single tick' ],
    [ qq{''' '' '''}, q{''' '' '''}, 'containing 2 single ticks' ],
    [ qq{'''foo'''bar'''}, qq{'''foo'''}, 'invalid: triple-quotes appear within ml string' ],
  );
};

done_testing;
