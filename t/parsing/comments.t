use Test2::V0;
use TOML::Tiny;

is from_toml(q{
# Top comment.
  # Top comment.
# Top comment.

# [no-extraneous-groups-please]

[group] # Comment
answer = 42 # Comment
# no-extraneous-keys-please = 999
# Inbetween comment.
more = [ # Comment
  # What about multiple # comments?
  # Can you handle it?
  #
          # Evil.
# Evil.
  42, 42, # Comments within arrays are fun.
  # What about multiple # comments?
  # Can you handle it?
  #
          # Evil.
# Evil.
# ] Did I fool you?
] # Hopefully not.
}), {
  group => {
    answer => 42,
    more   => [42, 42],
  }
}, 'comments everywhere';

is from_toml(q{
# full line comment
foo='bar' #comment
}),
  {foo => 'bar'}, 'comment with eol at eof';

is from_toml(q{
# full line comment
foo='bar' #comment}),
  {foo => 'bar'}, 'comment at eof';

done_testing;
