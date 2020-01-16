use Test2::V0;
use TOML::Tiny;
use DateTime::Format::RFC3339;

my %args = (
  inflate_datetime => sub{
    my $str = shift;
    my $dt  = DateTime::Format::RFC3339->parse_datetime($str);
    $dt->set_time_zone('UTC');
    ''.$dt;
  },
);

is from_toml(q{x=1987-07-05T17:45:00Z}, %args),          {x => '1987-07-05T17:45:00Z'},           'utc';
is from_toml(q{x=1977-06-28T07:32:00-05:00}, %args),     {x => '1977-06-28T12:32:00Z'},           'offset';
is from_toml(q{x=1977-12-21T10:32:00.555+07:00}, %args), {x => '1977-12-21T03:32:00.555000000Z'}, 'milliseconds';

done_testing;
