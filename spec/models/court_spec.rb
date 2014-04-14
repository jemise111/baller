require 'spec_helper'

describe Court do

  it { should have_many(:comments).dependent(:delete_all) }
  it { should have_many(:games).dependent(:delete_all) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:borough) }
  it { should validate_numericality_of(:latitude) }
  it { should validate_numericality_of(:longitude) }
  it { should validate_numericality_of(:num_courts) }

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
      expect(court.distance_to([40.7826, -73.9644])).to eq(0)
      expect(court.distance_to([40.78, -73.96])).to be_within(0.001).of(0.47)
    end
  end

  describe "#has_current_games?" do
    it "should return true if a court has games that aren't over 24 hours past" do
      court.games << Game.create(start_at: DateTime.now)
      expect(court.has_current_games?).to eq(true)
    end
    it "should return false if a court has no games that aren't over 24 horus past" do
      court.games.clear
      expect(court.has_current_games?).to eq(false)
    end
  end
end
