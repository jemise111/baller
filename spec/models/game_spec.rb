require 'spec_helper'

describe Game do

  it { should have_and_belong_to_many(:users) }
  it { should belong_to(:court) }
  it { should validate_presence_of(:start_at)}

  subject(:game) { Game.create(start_at: DateTime.new(DateTime.now.year + 1, 03, 04), skill_level: 3) }
  describe '.new' do
    it 'should be created with a start_at, created_at time, skill_level' do
      expect(game.start_at).to eq(DateTime.new(DateTime.now.year + 1, 03, 04))
      expect(game.created_at).to be_within(1).of(Time.now)
      expect(game.skill_level).to eq(3)
    end
  end
  describe '#past?' do
    it 'should return true if a game is at least 24 hours in the past' do
      past_game = Game.create(start_at: (Time.now - 25*60*60).to_datetime)
      expect(past_game.past?).to eq(true)
      expect(game.past?).to eq(false)
    end
  end
  describe "#time_info" do
    it "should return string containing game's datetime information" do
      # Use 4 hours ahead for eastern standard time
      my_game = Game.create(start_at: DateTime.new(2014, 4, 7, 14, 0, 0))
      expect(my_game.time_info).to eq("Mon 04/07/14 at 10:00 am")
    end
  end
end
