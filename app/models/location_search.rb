# This should really be a module

class LocationSearch
  def self.lat_lon_from_zip_code(zip_code)
    result = Geocoder.search(zip_code).first
    [result.latitude, result.longitude]
  end
end
