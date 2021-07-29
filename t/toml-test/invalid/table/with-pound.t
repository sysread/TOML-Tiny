# File automatically generated from BurntSushi/toml-test
use Test2::V0;
use TOML::Tiny;

open my $fh, '<', "./t/toml-test/invalid/table/with-pound.toml" or die $!;
my $toml = do{ local $/; <$fh>; };
close $fh;

ok dies(sub{ scalar from_toml($toml, strict => 1) }), 'strict_mode dies on table/with-pound';

done_testing;