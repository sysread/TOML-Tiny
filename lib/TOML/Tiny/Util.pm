package TOML::Tiny::Util;
# ABSTRACT: utility functions used by TOML::Tiny

use strict;
use warnings;
no warnings 'experimental';
use v5.18;

use TOML::Tiny::Grammar;

use parent 'Exporter';

our @EXPORT_OK = qw(
  is_strict_array
);

sub is_strict_array {
  my $arr = shift;

  my @types = map{
    my $value = $_;
    my $type;

    for (ref $value) {
      $type = 'array'   when 'ARRAY';
      $type = 'table'   when 'HASH';

      # Do a little heuristic guess-work
      $type = 'float'   when /Float/;
      $type = 'integer' when /Int/;
      $type = 'bool'    when /Boolean/;

      when ('') {
        for ($value) {
          $type = 'bool'     when /$Boolean/;
          $type = 'float'    when /$Float/;
          $type = 'integer'  when /$Integer/;
          $type = 'datetime' when /$DateTime/;
          default{ $type = 'string' };
        }
      }

      default{
        $type = $_;
      }
    }

    $type;
  } @$arr;

  my $t = shift @types;

  for (@types) {
    return (undef, "expected value of type $t, but found $_")
      if $_ ne $t;
  }

  return (1, undef);
}

1;
