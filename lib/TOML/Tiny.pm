package TOML::Tiny;
# ABSTRACT: a minimal, pure perl TOML parser and serializer

use strict;
use warnings;
use TOML::Tiny::Parser;

use parent 'Exporter';

our @EXPORT = qw(
  from_toml
  to_toml
);

sub from_toml {
  my $source = shift;
  my $parser = TOML::Tiny::Parser->new(@_);
  my $toml = eval{ $parser->parse($source) };
  return ($toml, $@);
}

sub to_toml {
  my $data = shift;
}

1;
