requires 'perl'     => '>= 5.014';
requires 'JSON::PP' => '0';

recommends 'Types::Serialiser' => 0;

on test => sub{
  requires 'Test::Pod' => '0';
  requires 'Test2::V0' => '0';
};
