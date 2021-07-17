requires 'perl'         => '>= 5.018';
requires 'Carp'         => '0';
requires 'Data::Dumper' => '0';
requires 'Exporter'     => '0';
requires 'Math::BigInt' => '>= 1.999718';

recommends 'Types::Serialiser' => 0;

on test => sub{
  requires 'Data::Dumper' => '0';
  requires 'Test2::V0'    => '0';
  requires 'Test::Pod'    => '0';

  recommends 'DateTime'                  => '0';
  recommends 'DateTime::Format::RFC3339' => '0';
  recommends 'DateTime::Format::ISO8601' => '0';
  recommends 'TOML::Parser'              => '0';
};
