# encoding: utf-8

Geocoder.configure(:lookup => :test)
Geocoder::Lookup::Test.set_default_stub(
  [
    {
      'latitude'     => 40.7143528,
      'longitude'    => -74.0059731,
      'city'         => 'Ульяновск',
      'street'       => 'Промышленная',
      'street_name'  => 'Промышленная',
      'street_number'  => '36',
      'street_address' => 'Промышленная 36',
      'addres'      => 'New York, NY, USA',
      'state'        => 'New York',
      'state_code'   => 'NY',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)

def fixture_path
  File.expand_path("../../fixtures", __FILE__)
end

def load_fixture(file)
  File.read(fixture_path + '/' + file)
end
