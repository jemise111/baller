class Game < ActiveRecord::Base
  # set up dependency?
  has_and_belongs_to_many(:users)
  belongs_to(:court)
  validates(:start_at, presence: true)

  def send_game_tweet
    day_date = self.start_at.strftime("%a %D")
    time = self.start_at.strftime("%l:%M %P")
    content = "New pick up game on #{day_date} at #{time} at #{self.court.name}! Wanna ball? http://www.ballernycco.com/courts/#{self.court.id}"
    Twitter.send_tweet(content, self.court.latitude, self.court.longitude)
  end

  def past?
    start_at < (Time.now - 24*60*60).to_datetime
  end
end
