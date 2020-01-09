package TOML::Tiny::Writer;

use strict;
use warnings;

use feature qw(switch state);
no warnings qw(experimental);

use Data::Dumper;
use Scalar::Util qw(looks_like_number);
use TOML::Tiny::Grammar;

my @KEYS;

sub to_toml {
  my $data = shift;
  my @buff;

  for (ref $data) {
    when ('HASH') {
      for my $k (grep{ ref($data->{$_}) !~ /HASH|ARRAY/ } sort keys %$data) {
        my $key = to_toml_key($k);
        my $val = to_toml($data->{$k});
        push @buff, "$key=$val";
      }

      for my $k (grep{ ref $data->{$_} eq 'ARRAY' } sort keys %$data) {
        my @inline;
        my @table_array;

        for my $v (@{$data->{$k}}) {
          if (ref $v eq 'HASH') {
            push @table_array, $v;
          } else {
            push @inline, $v;
          }
        }

        if (@inline) {
          my $key = to_toml_key($k);
          my $val = to_toml(\@inline);
          push @buff, "$key=$val";
        }

        if (@table_array) {
          push @KEYS, $k;

          for (@table_array) {
            push @buff, '', '[[' . join('.', map{ to_toml_key($_) } @KEYS) . ']]';

            for my $k (sort keys %$_) {
              my $key = to_toml_key($k);
              my $val = to_toml($_->{$k});
              push @buff, "$key=$val";
            }
          }

          pop @KEYS;
        }
      }

      for my $k (grep{ ref $data->{$_} eq 'HASH' } sort keys %$data) {
        push @KEYS, $k;
        push @buff, '', '[' . join('.', map{ to_toml_key($_) } @KEYS) . ']';
        push @buff, to_toml($data->{$k});
        pop @KEYS;
      }

    }

    when ('ARRAY') {
      push @buff, '[' . join(', ', map{ to_toml($_) } @$data) . ']';
    }

    when ('SCALAR') {
      if ($$_ eq '1') {
        return 'true';
      } elsif ($$_ eq '0') {
        return 'false';
      } else {
        push @buff, to_toml($$_);
      }
    }

    when (/JSON::PP::Boolean/) {
      return $$data ? 'true' : 'false';
    }

    when ('') {
      for ($data) {
        when (looks_like_number($_)) {
          return $data;
        }

        when (/(?&DateTime) $TOML/x) {
          return $data;
        }

        default{
          return to_toml_string($data);
        }
      }
    }

    when ('Math::BigInt') {
      return $data->bstr;
    }

    when ('Math::BigFloat') {
      return $data->bstr;
    }

    when (defined) {
      die 'unhandled: '.Dumper($_);
    }

    default{
      die 'unhandled: '.Dumper($_);
    }
  }

  join "\n", @buff;
}

sub to_toml_key {
  my $str = shift;

  if ($str =~ /^[-_A-Za-z0-9]+$/) {
    return $str;
  }

  return qq{"$str"};
}

sub to_toml_string {
  state $escape = {
    "\n" => '\n',
    "\r" => '\r',
    "\t" => '\t',
    "\f" => '\f',
    "\b" => '\b',
    "\"" => '\"',
    "\\" => '\\\\',
    "\'" => '\\\'',
  };

  my ($arg) = @_;
  $arg =~ s/([\x22\x5c\n\r\t\f\b])/$escape->{$1}/g;
  $arg =~ s/([\x00-\x08\x0b\x0e-\x1f])/'\\u00' . unpack('H2', $1)/eg;

  return '"' . $arg . '"';
}

1;
