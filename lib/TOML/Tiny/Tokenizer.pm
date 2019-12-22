package TOML::Tiny::Tokenizer;

use strict;
use warnings;
use feature qw(switch);
no warnings qw(experimental);

use JSON::PP;
use TOML::Tiny::Grammar;

our $TOML = $TOML::Tiny::Grammar::GRAMMAR_V5;

sub tokenize {
  my $toml = shift;
  my @tokens;

  TOKEN: while ((pos($toml) // 0) < length($toml)) {
    for ($toml) {
      when (/\G ((?&Boolean)) $TOML/xgc) {
        push @tokens, ['boolean', $1];
      }

      when (/\G ((?&DateTime)) $TOML/xgc) {
        push @tokens, ['datetime', $1];
      }

      when (/\G ((?&Float)) $TOML/xgc) {
        push @tokens, ['float', tokenize_float($1)];
      }

      when (/\G ((?&Integer)) $TOML/xgc) {
        push @tokens, ['integer', tokenize_integer($1)];
      }

      when (/\G ((?&String)) $TOML/xgc) {
        push @tokens, ['string', tokenize_string($1)];
      }

      when (/\G ((?&KeyValuePairDecl)) $TOML/xgc) {
        push @tokens, tokenize_assignment($1);
      }

      when (/\G ((?&Array)) $TOML/xgc) {
        push @tokens, tokenize_array($1);
      }

      when (/\G ((?&InlineTable)) $TOML/xgc) {
        push @tokens, tokenize_inline_table($1);
      }

      when (/\G \[ (?&WS) ((?&Key)) (?&WS) \] (?&WS) (?&NL) $TOML/xgc) {
        push @tokens, ['table', tokenize_key($1)];
      }

      when (/\G \[\[ (?&WS) ((?&Key)) (?&WS) \]\] (?&WS) (?&NL) $TOML/xgc) {
        push @tokens, ['array-of-tables', tokenize_key($1)];
      }

      when (/\G (?: (?&WSChar) | (?&NLSeq) | (?&Comment) )+ $TOML/xgc) {
        next TOKEN;
      }

      default{
        my $prev = JSON::PP->new->pretty->encode($tokens[ scalar(@tokens) - 1 ]);
        my $substr = substr($toml, pos($toml), 30) // 'undef';
        die "syntax error at:\n-->$substr\n\nprevious token was: $prev\n";
      }
    }
  }

  return \@tokens;
}

sub tokenize_inline_table {
  my $toml = shift;
  my @items;

  $toml =~ s/^\s*\{\s*//;
  $toml =~ s/\s*\}\s*$//;

  ITEM: while ((pos($toml) // 0) < length($toml)) {
    for ($toml) {
      next ITEM when /\G\s*/gc;
      next ITEM when /\G\{/gc;
      next ITEM when /\G\}/gc;

      when (/\G ((?&KeyValuePair)) (?&WS) ,? $TOML/xgc) {
        push @items, tokenize_assignment($1);
      }

      default{
        die "invalid inline table syntax: $toml";
      }
    }
  }

  return ['inline-table', \@items];
}

sub tokenize_array {
  my $toml = shift;
  my @items;

  $toml =~ s/^\s*\[\s*//;
  $toml =~ s/\s*\]\s*$//;

  ITEM: while ((pos($toml) // 0) < length($toml)) {
    my $pos = pos($toml) // 0;
    for ($toml) {
      when (/\G ((?&Value)) (?&WS) [,]? $TOML/xgc) {
        push @items, @{ tokenize($1) };
      }

      next ITEM when /\G\s*/gc;
      next ITEM when /\G\[/gc;
      next ITEM when /\G\]/gc;

      default{
        die "invalid array syntax: $toml";
      }
    }
  }

  return ['array', \@items];
}

sub tokenize_assignment {
  my $toml = shift;

  for ($toml) {
    when (/\G(?&WS) ((?&Key)) (?&WS) = (?&WS) ((?&Value)) (?&NL)? $TOML/xgc) {
      my $key = tokenize_key($1);
      my $val = tokenize($2);
      return ['assignment', $key, @$val];
    }

    default{
      die "invalid assignment syntax: $toml";
    }
  }
}

sub tokenize_key {
  my $toml = shift;

  for ($toml) {
    return ['dotted-key', $1] when /^ ((?&DottedKey)) $TOML/x;
    return ['quoted-key', $1] when /^ ((?&QuotedKey)) $TOML/x;
    return ['bare-key', $1]   when /^ ((?&BareKey)) $TOML/x;

    default{
      die "invalid key: syntax $toml";
    }
  }
}

sub tokenize_string {
  my $toml = shift;
  my $str = '';

  for ($toml) {
    when (/^ ((?&MultiLineString)) $TOML/x) {
      $str = substr $1, 3, length($1) - 6;
      $str =~ s/^(?&WS) (?&NL) $TOML//x;
    }

    when (/^ ((?&BasicString)) $TOML/x) {
      $str = substr($1, 1, length($1) - 2);
    }

    when (/^ ((?&MultiLineStringLiteral)) $TOML/x) {
      $str = substr $1, 3, length($1) - 6;
      $str =~ s/^(?&WS) (?&NL) $TOML//x;
    }

    when (/^ ((?&StringLiteral)) $TOML/x) {
      $str = substr($1, 1, length($1) - 2);
    }

    default{
      die "invalid string syntax: $toml";
    }
  }

  return ''.$str;
}

sub tokenize_integer {
  my $toml = shift;

  for ($toml) {
    when (/(?&Oct) $TOML/x) {
      $toml =~ s/^0o/0/; # convert to perl's octal format
      return oct $toml;
    }

    when (/(?&Bin) $TOML/x) {
      return oct $toml;
    }

    when (/(?&Hex) $TOML/x) {
      return hex $toml;
    }

    when (/(?&Dec) $TOML/x) {
    }

    default{
      die "invalid datetime syntax: $toml";
    }
  }

  return 0 + $toml;
}

sub tokenize_float {
  my $toml = shift;
  return 0 + $toml;
}

1;
