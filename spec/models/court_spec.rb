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

  describe '#distance_to?' do
    it 'should return true if court is close to latitudue, longitude args' do
      expect(court.is_close_to?(40.7826, -73.9644)).to eq(true)
    end
    it 'should return false if court is far away' do
      expect(court.is_close_to?(80, -73.9644)).to eq(false)
    end
  end
end
