use strict;
use warnings;

use Test2::V0;
use TOML::Tiny qw(from_toml);
use TOML::Tiny::Tokenizer;

#-------------------------------------------------------------------------------
# A single huge dotted key (a.a.a.....a = 1) must not materialize its full
# per-segment list before being rejected. The parser already bounds the
# combined key-path depth in scan_to_key, but only after the tokenizer has
# split the entire key into an array. Bounding the split in the tokenizer --
# tied to the same max_depth -- rejects an over-limit key without first
# building the whole segment list.
#-------------------------------------------------------------------------------

subtest 'tokenizer bounds dotted-key segments at max_depth' => sub {
  my $max = 16;
  my $tok = TOML::Tiny::Tokenizer->new(source => '', max_depth => $max);

  my $ok_key = join('.', ('a') x $max);
  my $keys   = $tok->tokenize_key($ok_key);
  is(scalar(@$keys), $max, "a key with exactly max_depth ($max) segments tokenizes");

  my $big_key = join('.', ('a') x ($max + 50));
  my $err = dies { $tok->tokenize_key($big_key) };
  ok($err, 'over-limit dotted key is rejected during tokenization');
  like($err, qr/depth/i, 'tokenizer error mentions depth');
};

subtest 'from_toml rejects a huge single dotted key' => sub {
  my $src = join('.', ('a') x 100_000) . ' = 1';
  my ($data, $err) = from_toml($src);
  ok($err, 'pathologically long dotted key is rejected');
  like($err, qr/depth/i, 'error mentions depth');
};

subtest 'configurable max_depth bounds dotted keys end to end' => sub {
  my $within = join('.', ('a') x 10) . ' = 1';
  my ($ok_data, $ok_err) = from_toml($within, max_depth => 16);
  ok(!$ok_err, 'dotted key within max_depth is accepted') or diag($ok_err);

  my $over = join('.', ('a') x 32) . ' = 1';
  my ($bad_data, $bad_err) = from_toml($over, max_depth => 16);
  ok($bad_err, 'dotted key over max_depth is rejected');
};

done_testing;
