package TOML::Tiny;
# ABSTRACT: a minimal TOML parser and serializer

use strict;
use warnings;

use TOML::Tiny::Grammar;

our $GRAMMAR_V5 = $TOML::Tiny::Grammar::GRAMMAR_V5;

1;
