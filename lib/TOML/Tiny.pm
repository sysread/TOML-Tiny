package TOML::Tiny;
# ABSTRACT: a minimal, pure perl TOML parser and serializer

use strict;
use warnings;
use feature qw(switch);
no warnings qw(experimental);

use TOML::Tiny::Parser;
use TOML::Tiny::Writer;

use parent 'Exporter';

our @EXPORT = qw(
  from_toml
  to_toml
);

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

1;
