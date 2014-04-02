class Court < ActiveRecord::Base

  # maximum distance in km for court to be 'close' to a zip code
  CLOSE_DISTANCE = 2

  has_many(:comments, dependent: :delete_all)
  has_many(:games, dependent: :delete_all)
  validates(:name, presence: true)
  validates(:location, presence: true)
  validates(:borough, presence: true,
                     inclusion: ['Bronx', 'Queens', 'Brooklyn', 'Manhattan', 'Staten Island'])
  # DRY this up
  validates(:num_courts, numericality: true)
  validates(:latitude, numericality: true)
  validates(:longitude, numericality: true)

  def distance_to(lat, lon)
    earthRadius = 6371 # Earth's radius in KM

        # convert degrees to radians
        def convDegRad(value)
          unless value.nil? or value == 0
                value = (value/180) * Math::PI
          end
        return value
        end

    deltaLat = (self.latitude - lat)
    deltaLon = (self.longitude - lon)
    deltaLat = convDegRad(deltaLat)
    deltaLon = convDegRad(deltaLon)

    # Calculate square of half the chord length between latitude and longitude
    a = Math.sin(deltaLat/2) * Math.sin(deltaLat/2) +
        Math.cos((lat/180 * Math::PI)) * Math.cos((self.latitude/180 * Math::PI)) *
        Math.sin(deltaLon/2) * Math.sin(deltaLon/2);

    # Calculate the angular distance in radians
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

    distance = earthRadius * c

    return distance # in kilometers
  end
end
