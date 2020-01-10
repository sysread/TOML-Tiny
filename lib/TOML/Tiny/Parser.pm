package TOML::Tiny::Parser;

use strict;
use warnings;
no warnings qw(experimental);
use v5.18;

use Carp;
use Data::Dumper;
use List::Util qw(all);
use Scalar::Util qw(looks_like_number);
use TOML::Tiny::Grammar;
use TOML::Tiny::Tokenizer;

our $TRUE  = 1;
our $FALSE = 0;

eval{
  require Types::Serialiser;
  $TRUE = Types::Serialiser::true();
  $FALSE = Types::Serialiser::false();
};

sub new {
  my ($class, %param) = @_;
  bless{
    inflate_datetime => $param{inflate_datetime} || sub{ shift },
    inflate_boolean  => $param{inflate_boolean}  || sub{ shift eq 'true' ? $TRUE : $FALSE },
    strict_arrays    => $param{strict_arrays},
    annotated        => $param{annotated},
  }, $class;
}

sub next_token {
  my $self = shift;
  return unless $self->{tokenizer};
  my $token = $self->{tokenizer}->next_token;
  return $token;
}

sub parse {
  my ($self, $toml) = @_;

  $self->{tokenizer} = TOML::Tiny::Tokenizer->new(source => $toml);
  $self->{keys}      = [];
  $self->{root}      = {};
  $self->{tables}    = {}; # "seen" hash of explicitly defined table names

  $self->parse_table;
  my $result = $self->{root};

  delete $self->{tokenizer};
  delete $self->{keys};
  delete $self->{root};
  delete $self->{tables};

  return annotate($result) if $self->{annotated};
  return $result;
}

sub parse_error {
  my ($self, $token, $msg) = @_;
  my $line = $token ? $token->line : 'EOF';
  if ($self->{annotated}) {
    my $root = Dumper($self->{root});
    my $tok  = Dumper($token);
    my $src  = substr $self->{tokenizer}{source}, $self->{tokenizer}{position} - 20, 40;

    confess qq{
toml parse error at line $line:
    $msg

Current token:
$tok

Parse state:
$root

Source near location of error:
...
$src
...

    };
  } else {
    die "toml parse error at line $line: $msg\n";
  }
}

sub expect_type {
  my ($self, $token, $expected) = @_;
  my $actual = $token->type;
  $self->parse_error($token, "expected $expected, but found $actual")
    unless $actual eq $expected;
}


sub push_keys {
  my ($self, $token) = @_;
  push @{ $self->{keys} }, $token->value;
}

sub pop_keys {
  my $self = shift;
  pop @{ $self->{keys} };
}

sub get_keys {
  my $self = shift;
  return map{ @$_ } @{ $self->{keys} };
}

sub set_keys {
  my $self  = shift;
  my $value = shift // $self->parse_value;
  my @keys  = $self->get_keys;
  my $key   = pop @keys;
  my $node  = $self->scan_to_key(\@keys);
  $self->parse_error(undef, 'duplicate key: '.join('.', @keys, $key))
    if exists $node->{$key};
  $node->{$key} = $value;
}

sub scan_to_key {
  my ($self, $keys) = @_;
  my $node = $self->{root};

  for my $key (@$keys) {
    if (exists $node->{$key}) {
      for (ref $node->{$key}) {
        $node = $node->{$key}     when /HASH/;
        $node = $node->{$key}[-1] when /ARRAY/;
        default{
          my $full_key = join '.', @$keys;
          die "$full_key is already defined\n";
        }
      }
    }
    else {
      $node = $node->{$key} = {};
    }
  }

  return $node;
}


sub parse_table {
  my $self  = shift;
  my $token = shift // $self->next_token;
  $self->expect_type($token, 'table');
  $self->push_keys($token);
  $self->scan_to_key([$self->get_keys]);

  my @keys = $self->get_keys;
  my $key = join '.', @keys;
  if (exists $self->{tables}{$key}) {
    # Tables cannot be redefined, *except* when doing so within a goddamn table
    # array. Gawd I hate TOML.
    my $in_a_stupid_table_array = 0;
    my $node = $self->{root};
    for my $key (@keys) {
      if (exists $node->{$key} && ref($node->{$key}) eq 'ARRAY') {
        $in_a_stupid_table_array = 1;
        last;
      } else {
        $node = $node->{$key};
      }
    }

    $self->parse_error($token, "table $key is already defined")
      unless $in_a_stupid_table_array;
  } else {
    $self->{tables}{$key} = 1;
  }

  TOKEN: while (my $token = $self->next_token) {
    for ($token->type) {
      next TOKEN when /EOL/;

      when (/key/) {
        $self->expect_type($self->next_token, 'assign');
        $self->push_keys($token);
        $self->set_keys;
        $self->pop_keys;

        if (my $eol = $self->next_token) {
          $self->expect_type($eol, 'EOL');
        } else {
          return;
        }
      }

      when (/array_table/) {
        $self->pop_keys;
        @_ = ($self, $token);
        goto \&parse_array_table;
      }

      when (/table/) {
        $self->pop_keys;
        @_ = ($self, $token);
        goto \&parse_table;
      }

      default{
        $self->parse_error($token, "expected key-value pair, table, or array of tables but got $_");
      }
    }
  }
}

sub parse_array_table {
  my $self = shift;
  my $token = shift // $self->next_token;
  $self->expect_type($token, 'array_table');
  $self->push_keys($token);

  my @keys = $self->get_keys;
  my $key  = pop @keys;
  my $node = $self->scan_to_key(\@keys);
  $node->{$key} //= [];
  push @{ $node->{$key} }, {};

  TOKEN: while (my $token = $self->next_token) {
    for ($token->type) {
      next TOKEN when /EOL/;

      when (/key/) {
        $self->expect_type($self->next_token, 'assign');
        $self->push_keys($token);
        $self->set_keys;
        $self->pop_keys;
      }

      when (/array_table/) {
        $self->pop_keys;
        @_ = ($self, $token);
        goto \&parse_array_table;
      }

      when (/table/) {
        $self->pop_keys;
        @_ = ($self, $token);
        goto \&parse_table;
      }

      default{
        $self->parse_error($token, "expected key-value pair, table, or array of tables but got $_");
      }
    }
  }
}

sub parse_key {
  my $self  = shift;
  my $token = shift // $self->next_token;
  $self->expect_type($token, 'key');
  return $token->value;
}

sub parse_value {
  my $self = shift;
  my $token = shift // $self->next_token;

  for ($token->type) {
    when (/float/) {
      if ($self->{annotated}) {
        return $token->value;
      } else {
        use bignum;
        return $token->value + 0;
      }
    }

    when (/integer/) {
      if ($self->{annotated}) {
        return $token->value;
      } else {
        for (my $n = $token->value) {
          use bigint;

          when (/(?&Oct) $TOML/x) {
            $n =~ s/^0o/0/; # convert to perl's octal format
            return oct $n;
          }

          when (/(?&Bin) $TOML/x) {
            return oct $n;
          }

          when (/(?&Hex) $TOML/x) {
            return hex $n;
          }

          default{
            return $n + 0;
          }
        }
      }
    }

    return $token->value when /string/;
    return $self->{inflate_boolean}->($token->value) when /bool/;
    return $self->{inflate_datetime}->($token->value) when /datetime/;
    return $self->parse_inline_table when /inline_table/;
    return $self->parse_inline_array when /inline_array/;

    default{
      $self->parse_error($token, "value expected (bool, number, string, datetime, inline array, inline table), but found $_");
    }
  }
}

sub parse_inline_array {
  my $self = shift;
  my @array;

  TOKEN: while (my $token = $self->next_token) {
    for ($token->type) {
      next TOKEN when /comma/;
      next TOKEN when /EOL/;
      last TOKEN when /inline_array_close/;

      default{
        push @array, $self->parse_value($token);
      }
    }
  }

  if (@array > 1 && $self->{strict_arrays}) {
    my @types = map{
      my $type;

      if (my $ref = ref $_) {
        $type = $ref eq 'ARRAY' ? 'array' : 'table';
      }
      else {
        if (/^(true|false)$/) {
          $type = 'bool';
        }
        elsif (looks_like_number($_)) {
          if ("$_" =~ /[.]/) {
            $type = 'float';
          } else {
            $type = 'integer';
          }
        }
        elsif (/(?&DateTime) $TOML/x) {
          $type = 'datetime';
        }
        else {
          $type = 'string';
        }
      }
    } @array;

    my $t = shift @types;
    for (@types) {
      $self->parse_error(undef, "expected value of type $t, but found $_")
        if $_ ne $t;
    }
  }

  return \@array;
}

sub parse_inline_table {
  my $self  = shift;
  my $table = {};

  TOKEN: while (my $token = $self->next_token) {
    for ($token->type) {
      next TOKEN when /comma/;
      last TOKEN when /inline_table_close/;

      when (/key/) {
        $self->expect_type($self->next_token, 'assign');
        my $key = $token->value->[0];
        $table->{ $key } = $self->parse_value;
      }

      default{
        $self->parse_error($token, "inline table expected key-value pair, but found $_");
      }
    }
  }

  return $table;
}

sub annotate {
  my $value = shift;

  for (ref $value) {
    when ('HASH') {
      $value->{$_} = annotate($value->{$_})
        for keys %$value;

      return $value;
    }

    when ('ARRAY') {
      my $is_table_array = @$value == 0 || grep{ ref($_) ne 'HASH' } @$value;

      $value->[$_] = annotate($value->[$_])
        for 0..(scalar(@$value) - 1);

      if ($is_table_array) {
        return {type => 'array', value => $value};
      } else {
        return $value;
      }
    }

    when ('JSON::PP::Boolean') {
      return {type => 'bool', value => $value ? 'true' : 'false'};
    }

    default{
      if ($value =~ /^(true|false)$/) {
        return {type => 'bool', value => $value};
      }

      if ($value =~ /^(?&Float)$ $TOML/x) {
        return {type => 'float', value => $value};
      }

      if ($value =~ /^(?&Integer)$ $TOML/x) {
        return {type => 'integer', value => $value};
      }

      if ($value =~ /^(?&DateTime)$ $TOML/x) {
        return {type => 'datetime', value => $value};
      }

      return {
        type  => 'string',
        value => $value,
      };
    }
  }
}

1;
