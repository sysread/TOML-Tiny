package TOML::Tiny::Tokenizer;

use strict;
use warnings;
no warnings qw(experimental);
use charnames qw(:full);
use v5.18;

use TOML::Tiny::Grammar;

use Class::Struct 'TOML::Tiny::Token' => {
  type  => '$',
  line  => '$',
  pos   => '$',
  value => '$',
};

sub new {
  my ($class, %param) = @_;

  my $self = bless{
    source       => $param{source},
    is_exhausted => 0,
    position     => 0,
    line         => 0,
    tokens       => [],
  }, $class;

  return $self;
}

sub next_token {
  my $self = shift;

  if (!defined($self->{source})) {
    return;
  }

  if ($self->{is_exhausted}) {
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

  while (!defined($token) && !$self->{is_exhausted}) {
    for ($self->{source}) {
      when (/\G (?&NL) $TOML/xgc) {
        ++$self->{line};
        $token = $self->_make_token('EOL');
      }

      when (/\G (?&WSChar)+ $TOML/xgc) {
        ;
      }

      when (/\G ((?&Key)) (?= (?&WS) =) $TOML/xgc) {
         $token = $self->_make_token('key', $1);
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

  my $token = TOML::Tiny::Token->new(
    type  => $type,
    line  => $self->{line},
    pos   => $self->{position},
  );

  $self->update_position;

  if (my $tokenize = $self->can("tokenize_$type")) {
    $value = $tokenize->($self, $value);
  }

  $token->value($value);

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
  $self->{is_exhausted} = $self->{position} >= length($self->{source});
}

sub error {
  my $self  = shift;
  my $token = shift;
  my $msg   = shift // 'unknown';
  my $line  = $token ? $token->line : $self->{line};
  die "toml: parse error at line $line: $msg\n";
}

sub tokenize_key {
  my $self = shift;
  my $toml = shift;

  for ($toml) {
    my @parts;

    $toml =~ qr{
      (
        (?:
          ( (?&QuotedKey) | (?&BareKey) )
          [.]?
          (?{push @parts, $^N})
        )+
      )
      $TOML
    }x;

    for (@parts) {
      s/^["']//;
      s/["']$//;
    }

    return \@parts;
  }
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
  my $str = '';

  for ($toml) {
    when (/^ ((?&MultiLineString)) $TOML/x) {
      $str = substr $1, 3, length($1) - 6;

      my @newlines = $str =~ /((?&NL)) $TOML/xg;
      $self->{line} += scalar( grep{ defined $_ } @newlines );

      $str =~ s/^(?&WS) (?&NL) $TOML//x;
      $str =~ s/\\(?&NL)\s* $TOML//xgs;
      $str = $self->unescape_str($str);
    }

    when (/^ ((?&BasicString)) $TOML/x) {
      $str = substr($1, 1, length($1) - 2);
      $str = $self->unescape_str($str);
    }

    when (/^ ((?&MultiLineStringLiteral)) $TOML/x) {
      $str = substr $1, 3, length($1) - 6;

      my @newlines = $str =~ /(?&NL) $TOML/xg;
      $self->{line} += scalar( grep{ defined $_ } @newlines );

      $str =~ s/^(?&WS) (?&NL) $TOML//x;
      $str =~ s/\\(?&NL)\s* $TOML//xgs;
    }

    when (/^ ((?&StringLiteral)) $TOML/x) {
      $str = substr($1, 1, length($1) - 2);
    }
  }

  return ''.$str;
}

# Adapted from TOML::Parser::Util
sub unescape_str {
  my $self = shift;
  my $str = shift;

  $str =~ s/((?&EscapeChar)) $TOML/
    my $ch = $1; for ($1) {
      $ch = "\x08" when '\b';
      $ch = "\x09" when '\t';
      $ch = "\x0A" when '\n';
      $ch = "\x0C" when '\f';
      $ch = "\x0D" when '\r';
      $ch = "\x22" when '\"';
      $ch = "\x2F" when '\/';
      $ch = "\x5C" when '\\\\';

      default{
        my $hex = hex substr($ch, 2);
        if (charnames::viacode($hex)) {
          $ch = chr $hex;
        } else {
          $self->error(undef, "invalid unicode escape: $ch");
        }
      }
    }

    $ch;
  /xge;

  return $str;
}

1;
