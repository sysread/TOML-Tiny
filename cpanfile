requires 'perl' => '>= 5.014';
requires 'Scalar::Util' => '>= 1.14';

recommends 'Types::Serialiser' => 0;

on test => sub{
  requires 'Data::Dumper'              => '0';
  requires 'DateTime::Format::ISO8601' => '0';
  requires 'TOML::Parser'              => '0';
  requires 'Test2::V0'                 => '0';
  requires 'Test::Pod'                 => '0';
};
