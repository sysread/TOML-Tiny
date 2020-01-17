requires 'perl' => '>= 5.018';

requires 'Scalar::Util'              => '>= 1.14';
requires 'Data::Dumper'              => '0';
requires 'DateTime::Format::RFC3339' => '0';
requires 'Math::BigInt'              => '>= 1.999718';

recommends 'Types::Serialiser' => 0;

on test => sub{
  requires 'Data::Dumper'              => '0';
  requires 'DateTime::Format::RFC3339' => '0';
  requires 'TOML::Parser'              => '0';
  requires 'Test2::V0'                 => '0';
  requires 'Test::Pod'                 => '0';
};
