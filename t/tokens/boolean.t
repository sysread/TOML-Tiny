use Test2::V0;
use TOML::Tiny::Grammar;

my $re = qr{ ((?&Boolean)) $TOML }x;

like 'true', $re, 'true';
like 'false', $re, 'false';
unlike 'invalid', $re, 'invalid';

done_testing;
