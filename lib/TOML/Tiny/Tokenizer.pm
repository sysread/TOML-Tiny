package TOML::Tiny::Tokenizer;
# ABSTRACT: tokenizer used by TOML::Tiny

use strict;
use warnings;
no warnings qw(experimental);
use charnames qw(:full);
use v5.18;

use Carp qw(croak);

use TOML::Tiny::Grammar qw(
    $Comment
    $CRLF
    $DateTime
    $EOL
    $Escape
    $Float
    $Integer
    $SimpleKey
    $String
    $WS
);

sub new {
  my ($class, %param) = @_;

  # Upper bound on the number of segments in a single dotted key, matching the
  # parser's nesting-depth guard. Defaults to the parser's default so a
  # standalone tokenizer is guarded too.
  my $max_depth = defined $param{max_depth} ? $param{max_depth} : 128;

  # max_depth is interpolated into regex quantifiers ({0,N} / {N}) below. A
  # negative or non-integer value would build a malformed regex (a literal,
  # non-matching "{0,-5}") that silently breaks all key matching, so reject it
  # up front as the usage error it is.
  croak "max_depth must be a non-negative integer (got '$max_depth')"
    unless $max_depth =~ /\A[0-9]+\z/;

  # A dotted key bounded to at most $max_depth + 1 segments. The key-matching
  # regexes below use this instead of the unbounded $Key: matching an unbounded
  # $DottedKey over a pathologically long key makes the regex engine allocate
  # state proportional to the segment count (hundreds of MB for a ~1 MB input)
  # before any depth check runs. Bounding the repetition caps that to
  # O($max_depth). An over-limit key fails to match here and is reported as a
  # depth error at the syntax-error fallthrough in next_token. The bound has no
  # leading-optional or required-dot pitfalls (cf. the EOL fix and over_depth_key
  # note), so it stays linear on dot-free input.
  my $bounded_key = qr/$SimpleKey (?: $WS* \. $WS* $SimpleKey){0,$max_depth}/x;

  my $self = bless{
    source        => $param{source},
    last_position => length $param{source},
    position      => 0,
    line          => 1,
    last_token    => undef,
    max_depth     => $max_depth,

    key_set     => qr/\G ($bounded_key) $WS* (?= =)/x,
    table       => qr/\G \[ $WS* ($bounded_key) $WS* \] $WS* (?:$EOL | $)/x,
    array_table => qr/\G \[\[ $WS* ($bounded_key) $WS* \]\] $WS* (?:$EOL | $)/x,

    # Detector for a dotted key (optionally a [table] / [[array]] header) deeper
    # than the limit, used ONLY on the syntax-error path to turn what would be a
    # generic "syntax error" into a clear depth error. It requires $max_depth
    # dot-terminated segments, so it must NOT run per token: a required-dot regex
    # forward-scans dot-free input to end-of-string (the same pessimization the
    # EOL fix removed). On the error path it runs at most once.
    over_depth_key => qr/\G \[{0,2} $WS* (?: $SimpleKey $WS* \. $WS* ){$max_depth}/x,
  }, $class;

  return $self;
}

sub last_token {
  my $self = shift;
  return $self->{last_token};
}

sub next_token {
  my $self = shift;

  return unless defined $self->{source}
      && $self->{position} < $self->{last_position};

  if (!$self->{last_token}) {
    return $self->{last_token} = {type => 'table', pos => 0, line => 1, value => []};
  }

  # Update the regex engine's position marker in case some other regex
  # attempted to match against the source string and reset it.
  pos($self->{source}) = $self->{position};

  my $token;
  my $type;
  my $value;

  my $key_set     = $self->{key_set};
  my $table       = $self->{table};
  my $array_table = $self->{array_table};

  state $simple = {
    '['     => 'inline_array',
    ']'     => 'inline_array_close',
    '{'     => 'inline_table',
    '}'     => 'inline_table_close',
    ','     => 'comma',
    '='     => 'assign',
    'true'  => 'bool',
    'false' => 'bool',
  };

  # More complex matches with regexps
  while ($self->{position} < $self->{last_position} && !defined($type)) {
    my $prev = $self->{last_token} ? $self->{last_token}{type} : 'EOL';
    my $newline = !!($prev eq 'EOL' || $prev eq 'table' || $prev eq 'array_table');

    for ($self->{source}) {
      /\G$WS+/gc;                # ignore whitespace
      /\G$Comment$/mgc && next;  # ignore comments

      last if /\G$/gc;

      if (/\G$EOL/gc) {
        ++$self->{line};
        $type = 'EOL';
        last;
      }

      if ($newline) {
        if (/$table/gc) {
          $type = 'table';
          $value = $self->tokenize_key($1);
          last;
        }

        if (/$array_table/gc) {
          $type = 'array_table';
          $value = $self->tokenize_key($1);
          last;
        }
      }

      if (/$key_set/gc) {
        $type = 'key';
        $value = $1;
        last;
      }

      if (/\G ( [\[\]{}=,] | true | false )/xgc) {
        $value = $1;
        $type = $simple->{$value};
        last;
      }

      if (/\G($String)/gc) {
        $type = 'string';
        $value = $1;
        last;
      }

      if (/\G($DateTime)/gc) {
        $type = 'datetime';
        $value = $1;
        last;
      }

      if (/\G($Float)/gc) {
        $type = 'float';
        $value = $1;
        last;
      }

      if (/\G($Integer)/gc) {
        $type = 'integer';
        $value = $1;
        last;
      }

      # Nothing matched. Before reporting a generic syntax error, check whether
      # we are stuck on a dotted key deeper than max_depth -- the bounded key
      # regexes above refuse to match such a key, so it lands here. Report it as
      # a depth error. This runs at most once (we are about to die either way),
      # so the required-dot detector cannot cause per-token scanning.
      if (/$self->{over_depth_key}/gc) {
        $self->error(undef, "exceeded maximum nesting depth of $self->{max_depth}");
      }

      my $substr = substr($self->{source}, $self->{position}, 30) // 'undef';
      die "toml syntax error on line $self->{line}\n\t-->|$substr|\n";
    }

    if ($type) {
      state $tokenizers = {};
      my $tokenize = $tokenizers->{$type} //= $self->can("tokenize_$type") || 0;

      $token = {
        line  => $self->{line},
        pos   => $self->{pos},
        type  => $type,
        value => $tokenize ? $tokenize->($self, $value) : $value,
        prev  => $self->{last_token},
      };

      # Unset the previous token's 'prev' key to prevent keeping the entire
      # chain of previously parsed tokens alive for the whole process.
      undef $self->{last_token}{prev};

      $self->{last_token} = $token;
    }

    $self->update_position;
  }

  return $token;
}

sub current_line {
  my $self = shift;
  my $rest = substr $self->{source}, $self->{position};
  my $stop = index $rest, "\n";
  substr $rest, 0, $stop;
}

sub update_position {
  my $self = shift;
  $self->{position} = pos($self->{source}) // 0;
}

sub error {
  my $self  = shift;
  my $token = shift;
  my $msg   = shift // 'unknown';
  my $line  = $token ? $token->{line} : $self->{line};
  die "toml: parse error at line $line: $msg\n";
}

sub tokenize_key {
  my $self  = shift;
  my $toml  = shift;
  my $limit = $self->{max_depth};
  my @keys;

  # Split one segment at a time rather than materializing the whole list up
  # front, so an over-long dotted key is rejected after $limit segments instead
  # of after building all of them. A single key's segment count is its absolute
  # depth from the root, so it is bounded exactly like nesting depth (see
  # TOML::Tiny::Parser::scan_to_key, which still enforces the *combined*
  # table+key depth this per-key bound cannot see).
  while ($toml =~ /\G ($SimpleKey) (?: $WS* \. $WS* )? /gcx) {
    my $seg = $1;
    $seg = $self->tokenize_string($seg) if $seg =~ m/^['"]/;
    push @keys, $seg;

    if (defined $limit && @keys > $limit) {
      $self->error(undef, "exceeded maximum nesting depth of $limit");
    }
  }

  return \@keys;
}

sub tokenize_float {
  $_[1] =~ tr/_//d;
  $_[1];
}

sub tokenize_integer {
  $_[1] =~ tr/_+//d;
  $_[1];
}

sub tokenize_string {
  my $self = shift;
  my $toml = shift;
  my $ml   = index($toml, q{'''}) == 0
          || index($toml, q{"""}) == 0;
  my $lit  = index($toml, q{'}) == 0;
  my $str  = '';

  if ($ml) {
    $str = substr $toml, 3, length($toml) - 6;
    my @newlines = $str =~ /($CRLF)/g;
    $self->{line} += scalar @newlines;
    $str =~ s/^$WS* $CRLF//x; # trim leading whitespace
    $str =~ s/\\$EOL\s*//xgs; # trim newlines from lines ending in backslash
  } else {
    $str = substr($toml, 1, length($toml) - 2);
  }

  if (!$lit) {
    $str = $self->unescape_str($str);
  }

  return $str;
}

sub unescape_chars {
  state $esc = {
    '\b'   => "\x08",
    '\t'   => "\x09",
    '\n'   => "\x0A",
    '\f'   => "\x0C",
    '\r'   => "\x0D",
    '\"'   => "\x22",
    '\/'   => "\x2F",
    '\\\\' => "\x5C",
  };

  if (exists $esc->{$_[0]}) {
    return $esc->{$_[0]};
  }

  my $hex = hex substr($_[0], 2);

  if ($hex < 0x10FFFF && charnames::viacode($hex)) {
    return chr $hex;
  }

  return;
}

sub unescape_str {
  state $re = qr/($Escape)/;
  $_[1] =~ s|$re|unescape_chars($1) // $_[0]->error(undef, "invalid unicode escape: $1")|xge;
  $_[1];
}

1;
