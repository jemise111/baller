class Court < ActiveRecord::Base
  # maximum distance in km for court to be 'close' to a zip code
  CLOSE_DISTANCE = 2

  has_many(:comments, dependent: :delete_all)
  has_many(:games, dependent: :delete_all)
  validates(:name, :location, :borough, presence: true)
  validates(:num_courts, :latitude, :longitude, numericality: true)

  def self.zip_code_search(zip_code)
    lat_lon = LocationSearch.lat_lon_from_zip_code(zip_code)
    result_courts = {}
    self.all.each do |court|
      if court.distance_to(lat_lon) < CLOSE_DISTANCE
        result_courts[court.distance_to(lat_lon)] = court
      end
    end
    result_courts
  end

  def distance_to(lat_lon)
    lat = lat_lon.first
    lon = lat_lon.last
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
