require 'spec_helper'

describe Game do
  subject(:game) { Game.create(start_at: Time.parse("6:00"), skill_level: 3) }
  describe '.new' do
    it 'should be created with a start_at, created_at time, skill_level' do
      expect(game.start_at).to eq(Time.parse("6:00"))
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
end
