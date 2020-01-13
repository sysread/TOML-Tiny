package TOML::Tiny;
# ABSTRACT: a minimal, pure perl TOML parser and serializer

use strict;
use warnings;
no warnings qw(experimental);
use v5.18;

use TOML::Tiny::Parser;
use TOML::Tiny::Writer;

use parent 'Exporter';

our @EXPORT = qw(
  from_toml
  to_toml
);

#-------------------------------------------------------------------------------
# TOML module compatibility
#-------------------------------------------------------------------------------
sub from_toml {
  my $source = shift;
  my $parser = TOML::Tiny::Parser->new(@_);
  my $toml = eval{ $parser->parse($source) };
  if (wantarray) {
    return ($toml, $@);
  } else {
    die $@ if $@;
    return $toml;
  }
}

sub to_toml {
  goto \&TOML::Tiny::Writer::to_toml;
}

#-------------------------------------------------------------------------------
# Object API
#-------------------------------------------------------------------------------
sub new {
  my ($class, %param) = @_;
  bless{ parser => TOML::Tiny::Parser->new(%param) }, $class;
}

sub encode {
  my ($self, $source) = @_;
  $self->{parser}->parse;
}

sub decode {
  my ($self, $data) = @_;
  TOML::Tiny::Writer::to_toml($data);
}

#-------------------------------------------------------------------------------
# For compatibility with TOML::from_toml's use of $TOML::Parser
#-------------------------------------------------------------------------------
sub parse {
  goto \&encode;
}

1;

=head1 SYNOPSIS

  use TOML::Tiny qw(from_toml to_toml);

  binmode STDIN,  ':encoding(UTF-8)';
  binmode STDOUT, ':encoding(UTF-8)';

  # Decoding TOML
  my $toml = do{ local $/; <STDIN> };
  my ($parsed, $error) = from_toml $toml;

  # Encoding TOML
  say to_toml({
    stuff => {
      about => ['other', 'stuff'],
    },
  });

  # Object API
  my $parser = TOML::Tiny->new;
  my $result = $parser->parse($toml);


=head1 DESCRIPTION

C<TOML::Tiny> implements a pure-perl parser and generator for the
L<TOML|https://github.com/toml-lang/toml> data format. It conforms to TOML
v5.0.

C<TOML::Tiny> strives to maintain an interface compatible to the L<TOML> and
L<TOML::Parser> modules, and could even be used to override C<$TOML::Parser>:

  use TOML;
  use TOML::Tiny;

  local $TOML::Parser = TOML::Tiny->new(...);
  say to_toml(...);


=head1 EXPORTS

=head2 from_toml

=head2 to_toml


=head1 OBJECT API

=head2 new

=head2 decode

=head2 encode

=head2 parse


=head1 COMPATIBILITY
