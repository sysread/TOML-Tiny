package TOML::Tiny::Tokenizer;
# ABSTRACT: tokenizer used by TOML::Tiny

use strict;
use warnings;
no warnings qw(experimental);
use charnames qw(:full);
use v5.18;

use TOML::Tiny::Grammar;

sub new {
  my ($class, %param) = @_;

  my $self = bless{
    source        => $param{source},
    last_position => length $param{source},
    position      => 0,
    line          => 0,
    tokens        => [],
  }, $class;

  return $self;
}

sub next_token {
  my $self = shift;

  if (!defined($self->{source})) {
    return;
  }

  if ($self->is_exhausted) {
    return;
  }

  if (!@{ $self->{tokens} }) {
    my $root = $self->_make_token('table', []);
    $self->push_token($root);
    return $root;
  }

  # Update the regex engine's position marker in case some other regex
  # attempted to match against the source string and reset it.
  pos($self->{source}) = $self->{position};

  my $token;

  while (!defined($token) && !$self->is_exhausted) {
    for ($self->{source}) {
      when (/\G (?&NL) $TOML/xgc) {
        ++$self->{line};
        $token = $self->_make_token('EOL');
      }

      when (/\G (?&WSChar)+ $TOML/xgc) {
        ;
      }

      when (/\G ((?&Key)) (?&WS) (?= =) $TOML/xgc) {
         $token = $self->_make_token('key', $1);
      }

      when (/\G \[ (?&WS) ((?&Key)) (?&WS) \] (?&WS) (?=(?&NL) | $)$TOML/xgc) {
        my $key = $self->tokenize_key($1);
        $token = $self->_make_token('table', $key);
      }

      when (/\G \[\[ (?&WS) ((?&Key)) (?&WS) \]\] (?&WS) (?=(?&NL) | $) $TOML/xgc) {
        my $key = $self->tokenize_key($1);
        $token = $self->_make_token('array_table', $key);
      }

      when (/\G \[ /xgc) {
        $token = $self->_make_token('inline_array', $1);
      }

      when (/\G \] /xgc) {
        $token = $self->_make_token('inline_array_close', $1);
      }

      when (/\G \{ /xgc) {
        $token = $self->_make_token('inline_table', $1);
      }

      when (/\G \} /xgc) {
        $token = $self->_make_token('inline_table_close', $1);
      }

      when (/\G ((?&Boolean)) $TOML/xgc) {
        $token = $self->_make_token('bool', $1);
      }

      when (/\G ((?&DateTime)) $TOML/xgc) {
        $token = $self->_make_token('datetime', $1);
      }

      when (/\G ((?&Float)) $TOML/xgc) {
        $token = $self->_make_token('float', $1);
      }

      when (/\G ((?&Integer)) $TOML/xgc) {
        $token = $self->_make_token('integer', $1);
      }

      when (/\G ((?&String)) $TOML/xgc) {
        $token = $self->_make_token('string', $1);
      }

      when (/\G = /xgc) {
        $token = $self->_make_token('assign', $1);
      }

      when (/\G , /xgc) {
        $token = $self->_make_token('comma', $1);
      }

      default{
        my $substr = substr($self->{source}, $self->{position} - 20, 40) // 'undef';
        die "toml syntax error on line $self->{line}\n\t--> $substr\n";
      }
    }

    $self->push_token($token);
    $self->update_position;
  }

  return $token;
}

sub push_token {
  my $self = shift;
  my $token = shift // return;
  push @{$self->{tokens}}, $token;
}

sub pop_token {
  my $self = shift;
  pop @{$self->{tokens}};
}

sub _make_token {
  my ($self, $type, $value) = @_;

  my $token = {
    type  => $type,
    line  => $self->{line},
    pos   => $self->{position},
    value => $self->can("tokenize_$type") ?  $self->can("tokenize_$type")->($self, $value) : $value,
  };

  return $token;
}

sub current_line {
  my $self = shift;
  my $rest = substr $self->{source}, $self->{position};
  my $stop = index $rest, "\n";
  substr $rest, 0, $stop;
}

sub is_exhausted {
  return $_[0]->{position} >= $_[0]->{last_position};
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
  my $self = shift;
  my $toml = shift;
  my @keys;

  while ($toml =~ s/^ ((?&SimpleKey)) [.]? $TOML//x) {
    push @keys, $1;
  }

  for (@keys) {
    s/^["']//;
    s/["']$//;
  }

  return \@keys;
}

sub tokenize_float {
  my $self = shift;
  my $toml = shift;
  $toml =~ s/_//g;
  $toml;
}

sub tokenize_integer {
  my $self = shift;
  my $toml = shift;
  $toml =~ s/_//g;
  $toml =~ s/^[+]//;
  return $toml;
}

sub tokenize_string {
  my $self = shift;
  my $toml = shift;
  my $ml   = $toml =~ /^(?:''')|(?:""")/;
  my $lit  = $toml =~ /^'/;
  my $str  = '';

  if ($ml) {
    $str = substr $toml, 3, length($toml) - 6;
    my @newlines = $str =~ /(\x0D?\x0A)/g;
    $self->{line} += scalar @newlines;
    $str =~ s/^(?&WS) (?&NL) $TOML//x; # trim leading whitespace
    $str =~ s/\\(?&NL)\s* $TOML//xgs;  # trim newlines from lines ending in backslash
  } else {
    $str = substr($toml, 1, length($toml) - 2);
  }

  if (!$lit) {
    $str = $self->unescape_str($str);
  }

  return ''.$str;
}

sub unescape_chars {
  state %esc = (
    '\b'   => "\x08",
    '\t'   => "\x09",
    '\n'   => "\x0A",
    '\f'   => "\x0C",
    '\r'   => "\x0D",
    '\"'   => "\x22",
    '\/'   => "\x2F",
    '\\\\' => "\x5C",
  );

  if (exists $esc{$_[0]}) {
    return $esc{$_[0]};
  }

  my $hex = hex substr($_[0], 2);

  if (charnames::viacode($hex)) {
    return chr $hex;
  }

  return;
}

sub unescape_str {
  state $re = qr/((?&EscapeChar)) $TOML/x;
  $_[1] =~ s|$re|unescape_chars($1) // $_[0]->error(undef, "invalid unicode escape: $1")|xge;
  $_[1];
}

1;
