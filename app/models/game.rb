class Game < ActiveRecord::Base
  # set up dependency?
  has_and_belongs_to_many(:users)
  belongs_to(:court)

  def past?
    start_at < (Time.now - 24*60*60).to_datetime
  end
end
