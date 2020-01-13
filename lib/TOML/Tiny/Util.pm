package TOML::Tiny::Util;

use strict;
use warnings;
no warnings 'experimental';
use v5.18;

use Scalar::Util qw(looks_like_number);
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
      $type = 'array'   when /ARRAY/;
      $type = 'table'   when /HASH/;
      $type = 'float'   when /Math::BigFloat/;
      $type = 'integer' when /Math::BigInt/;
      $type = 'bool'    when /JSON::PP::Boolean/;

      when ('') {
        for ($value) {
          $type = 'bool'      when /(?&Boolean)  $TOML/x;
          $type = 'float'     when /(?&Float)    $TOML/x;
          $type = 'integer'   when /(?&Integer)  $TOML/x;
          $type = 'datetime'  when /(?&DateTime) $TOML/x;
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
