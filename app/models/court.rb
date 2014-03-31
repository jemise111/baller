class Court < ActiveRecord::Base

  # maximum distance in km for court to be 'close' to a zip code
  CLOSE_DISTANCE = 2

  has_many(:comments)
  has_many(:games)
  validates(:name, presence: true)
  validates(:location, presence: true)
  validates(:borough, presence: true,
                     inclusion: ['Bronx', 'Queens', 'Brooklyn', 'Manhattan', 'Staten Island'])
  # DRY this up
  validates(:num_courts, numericality: true)
  validates(:latitude, numericality: true)
  validates(:longitude, numericality: true)
end
