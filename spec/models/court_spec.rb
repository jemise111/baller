require 'spec_helper'

describe Court do
  subject(:court) { Court.create(name: 'Test Park',
                                 location: '106 and Park',
                                 borough: 'Manhattan',
                                 num_courts: 3,
                                 latitude: 40.7826,
                                 longitude: -73.9644) }
  describe '.new' do
    it 'should be created with name, location, borough, number of courts, latitude, longitude' do
      expect(court.name).to eq('Test Park')
      expect(court.location).to eq('106 and Park')
      expect(court.borough).to eq('Manhattan')
      expect(court.num_courts).to eq(3)
      expect(court.latitude).to eq(40.7826)
      expect(court.longitude).to eq(-73.9644)
    end
  end

  describe '#distance_to' do
    it 'should return distance in km to the lat, long arguments' do
      expect(court.distance_to(40.7826, -73.9644)).to eq(0)
      expect(court.distance_to(40.78, -73.96)).to be_within(0.001).of(0.47)
    end
  end
end
