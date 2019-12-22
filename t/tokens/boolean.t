use Test2::V0;
use TOML::Tiny;

my $re = qr{ ((?&Boolean)) $TOML::Tiny::GRAMMAR_V5 }x;

like 'true', $re, 'true';
like 'false', $re, 'false';
unlike 'invalid', $re, 'invalid';

done_testing;
