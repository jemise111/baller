class Game < ActiveRecord::Base
  # set up dependency?
  has_and_belongs_to_many(:users)
  belongs_to(:court)
  validates(:start_at, presence: true)

  # validate that game start_at is in future
  # custom validation - use seconds in integer form


  # Might want different tweet messages, don't hardcode the string
  # Might store multiple messages in a hash
  # Store these different messages in a separate "Choose appropriate tweet" module or class
  def send_game_tweet
    content = "New pick up game on #{time_info} at #{self.court.name}! Wanna ball? http://www.ballernycco.com/courts/#{self.court.id}"
    Twitter::send_tweet(content, self.court.latitude, self.court.longitude)
  end

  # change name since this is for 24 hrs past
  # call it 'inactive' or 'stale'

  # make 24 a constant

  # A game is in the past if it took place more than 24 hours ago
  def past?
    start_at < (Time.now - 24*60*60).to_datetime
  end

  def time_info
    "#{start_at.strftime("%a %D")} at #{start_at.strftime("%l:%M %P")}"
  end
end
