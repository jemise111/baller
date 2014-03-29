class Court < ActiveRecord::Base
  has_many(:comments)
  validates(:name, presence: true)
  validates(:location, presence: true)
  validates(:borogh, presence: true,
                     inclusion: ['Bronx', 'Queens', 'Brooklyn', 'Manhattan', 'Staten Island'])
  # DRY this up
  validates(:num_courts, numericality: true)
  validates(:latitude, numericality: true)
  validates(:longitude, numericality: true)
end
