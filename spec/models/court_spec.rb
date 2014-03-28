require 'spec_helper'

describe Court do
  let(:court) { Court.new(name: 'Test Park',
                          location: '106 and Park',
                          borough: 'Queens',
                          num_courts: 3,
                          latitude: 43.12345,
                          longitude: -71.34856) }
  it 'should be created with name, location, borough, number of courts, latitude, longitude' do
    expect(court.name).to eq('Test Park')
    expect(court.location).to eq('106 and Park')
    expect(court.borough).to eq('Queens')
    expect(court.num_courts).to eq(3)
    expect(court.latitude).to eq(43.12345)
    expect(court.longitude).to eq(-71.34856)
  end
end
