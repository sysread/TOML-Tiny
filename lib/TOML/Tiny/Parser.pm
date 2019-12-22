package TOML::Tiny::Parser;

use strict;
use warnings;
use feature qw(switch);
no warnings qw(experimental);

use Carp;
use DDP;
use Data::Dumper;
use TOML::Tiny::Tokenizer;

our $TOML  = $TOML::Tiny::Grammar::GRAMMAR_V5;
our $TRUE  = 1;
our $FALSE = 0;

BEGIN{
  eval{
    require Types::Serialiser;
    $TRUE = Types::Serialiser::true();
    $FALSE = Types::Serialiser::false();
  };
}

sub new {
  my ($class, %param) = @_;
  return bless{
    inflate_datetime => $param{inflate_datetime},
    inflate_boolean  => $param{inflate_boolean},
  }, $class;
}

sub parse {
  my $self   = shift;
  my $tokens = TOML::Tiny::Tokenizer::tokenize(@_);
  my $root   = {};
  my $acc    = { root => $root, node => $root };
  $self->parse_token($_, $acc) for @$tokens;
  return $root;
}

sub parse_token {
  my $self   = shift;
  my $token  = shift;
  my $acc    = shift;
  my $type   = shift @$token;

  for ($type) {
    # Table
    when ('table') {
      my $keys = $self->parse_key(shift @$token);
      $acc->{node} = $self->mkpath($keys, $acc->{root});
    }

    # Array of tables
    when ('array-of-tables') {
      my $keys = $self->parse_key(shift @$token);
      my $last = pop @$keys;
      $acc->{node} = $self->mkpath($keys, $acc->{root});
      $acc->{node}{$last} ||= [];
      push @{ $acc->{node}{$last} } => $acc->{node} = {};
    }

    # Key-value pair
    when ('assignment') {
      my $keys = $self->parse_key(shift @$token);
      my $last = pop @$keys;
      my $value = $self->parse_value(shift @$token);
      my $node = $self->mkpath($keys, $acc->{node});
      $node->{$last} = $value;
    }
  }

  return $acc;
}

sub mkpath {
  my $self = shift;
  my $keys = shift;
  my $node = shift;

  for my $key (@$keys) {
    if (exists $node->{$key}) {
      for (ref $node->{$key}) {
        $node = $node->{$key}[-1] when 'ARRAY';
        $node = $node->{$key}     when 'HASH';
      }
    }
    else {
      $node = $node->{$key} ||= {};
    }
  }

  return $node;
}

sub parse_key {
  my ($self, $key) = @_;
  my $type = shift @$key;
  for ($type) {
    return $self->dotted_key(shift @$key) when 'dotted-key';
    return $self->quoted_key(shift @$key) when 'quoted-key';
    return $self->bare_key(shift @$key)   when 'bare-key';
  }
}

sub parse_value {
  my ($self, $token) = @_;
  my $type = shift @$token;

  for ($type) {
    return $self->datetime(@$token) when 'datetime';
    return $self->boolean(@$token)  when 'boolean';

    when ('array') {
      my $contents = shift @$token;
      return [ map{ $self->parse_value($_) } @$contents ];
    }

    when ('inline-table') {
      my $tokens = shift @$token;
      my $root   = {};
      my $acc    = {root => $root, node => $root};
      $self->parse_token($_, $acc) for @$tokens;
      return $root;
    }

    default{
      return shift @$token;
    }
  }
}

sub bare_key {
  my ($self, $key) = @_;
  return [$key];
}

sub quoted_key {
  my ($self, $key) = @_;
  $key =~ s/^"//;
  $key =~ s/"$//;
  return [$key];
}

sub dotted_key {
  my ($self, $key) = @_;
  my @parts = split /\./, $key;
  return \@parts;
}

sub number {
  my ($self, $n) = @_;
  defined $n ? 0 + $n : $n;
}

sub datetime {
  my ($self, $dt) = @_;

  if ($self->{inflate_datetime}) {
    my ($year, $month, $day, $hour, $minute, $second, $fractional, $offset) = $dt =~ qr{
        (?:
          (\d\d\d\d) - (\d\d) - (\d\d)  # yyyy-mm-dd
        )?

        (?:
          [T ]
          (\d\d) : (\d\d) : (\d\d)      # hh:mm:ss.fractional
          (?:[.] (\d+) )?

          ((?&Offset)?)
        )?

        $TOML::Tiny::Tokenizer::TOML
    }x;

    return {
      original   => $dt,
      year       => $self->number($year),
      month      => $self->number($month),
      day        => $self->number($day),
      hour       => $self->number($hour),
      minute     => $self->number($minute),
      second     => $self->number($second),
      fractional => $self->number($fractional),
      offset     => $offset,
    };
  } else {
    return $dt;
  }
}

sub boolean {
  my ($self, $bool) = @_;
  if ($self->{inflate_boolean}) {
    return $TRUE if $bool eq 'true';
    return $FALSE;
  } else {
    return $bool;
  }
}

1;
