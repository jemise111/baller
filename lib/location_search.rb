module LocationSearch
  def self.lat_lon_from_zip_code(zip_code)
    result = Geocoder.search(zip_code).first
    [result.latitude, result.longitude] unless result.nil?
  end
end
