
package TOML::Tiny::Faithful;
use parent TOML::Tiny;
use DateTime::Format::RFC3339;

use DateTime;
use Types::Serialiser; # ensures that Parser DTRT with booleans

our @EXPORT = qw(
  from_toml
  to_toml
);

sub _options {
  inflate_datetime => sub {
    DateTime::Format::RFC3339->parse_datetime(shift);
  },
  inflate_integer => sub { 
    use bignum;
    my $s = shift;
    $s =~ m/^0o/
	? Math::BigInt->from_oct($')
	: Math::BigInt->new($s);
  },
  inflate_float => sub { 0. + shift; },
  no_string_guessing => 1,
  datetime_formatter => DateTime::Format::RFC3339->new(),
}

sub new {
  my ($class, %param) = @_;
  bless TOML::Tiny->new(_options(), %param), $class;
}
sub from_toml {
  my $source = shift;
  TOML::Tiny::from_toml($source, _options(), @_);
}
sub to_toml {
  my $source = shift;
  TOML::Tiny::to_toml($source, _options(), @_);
}

1;

=head1 SYNOPSIS

  use TOML::Tiny::Faithful qw(from_toml to_toml);

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
  my $parser = TOML::Tiny::Faithful->new;
  my $data = $parser->decode($toml);
  say $parser->encode($data);


=head1 DESCRIPTION

C<TOML::Tiny::Faithful> is a trivial wrapper around C<TOML::Tiny>
which sets C<inflate_integer>, C<inflate_float>, C<inflate_datetime>,
C<no_string_guessing> and C<datetime_formatter> to try to make the
TOML output faithful to any input TOML.

=head1 SEE ALSO

=over

=item L<TOML::Tiny>

=back
