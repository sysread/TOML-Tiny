package TOML::Tiny::Parser;

use strict;
use warnings;
use feature qw(say switch);
no warnings qw(experimental);

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
  }, $class;
}

sub next_token {
  my $self = shift;
  return unless $self->{tokenizer};
  $self->{tokenizer}->next_token;
}

sub parse {
  my ($self, $toml) = @_;

  $self->{tokenizer} = TOML::Tiny::Tokenizer->new(source => $toml);
  $self->{keys} = [];
  $self->{root} = {};

  $self->parse_table;
  my $result = $self->{root};

  delete $self->{tokenizer};
  delete $self->{keys};
  delete $self->{root};

  return $result;
}

sub parse_error {
  my ($self, $token, $msg) = @_;
  my $line = $token ? $token->line : 'EOF';
  die "toml parse error at line $line: $msg\n";
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
  my $value = $self->parse_value;
  my @keys  = $self->get_keys;
  my $key   = pop @keys;
  my $node  = $self->scan_to_key(\@keys);
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

  TOKEN: while (my $token = $self->next_token) {
    for ($token->type) {
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
    return $token->value when /number/;
    return $token->value when /string/;
    return $self->{inflate_boolean}->($token->value) when /boolean/;
    return $self->{inflate_datetime}->($token->value) when /datetime/;
    return $self->parse_inline_table when /inline_table/;
    return $self->parse_inline_array when /inline_array/;

    default{
      $self->parse_error($token, "value expected (boolean, number, string, datetime, inline array, inline table), but found $_");
    }
  }
}

sub parse_inline_array {
  my $self = shift;
  my @array;

  TOKEN: while (my $token = $self->next_token) {
    for ($token->type) {
      next TOKEN when /comma/;
      last TOKEN when /inline_array_close/;

      default{
        push @array, $self->parse_value($token);
      }
    }
  }

  return \@array;
}

sub parse_inline_table {
  my $self = shift;

  my @keys = $self->get_keys;
  my $key  = pop @keys;
  my $node = $self->scan_to_key(\@keys);
  $node->{$key} //= {};

  TOKEN: while (my $token = $self->next_token) {
    for ($token->type) {
      next TOKEN when /comma/;
      last TOKEN when /inline_table_close/;

      when (/key/) {
        $self->expect_type($self->next_token, 'assign');
        $self->push_keys($token);
        $self->set_keys;
        $self->pop_keys;
      }

      default{
        $self->parse_error($token, "inline table expected key-value pair, but found $_");
      }
    }
  }

  return $node->{$key};
}

1;
