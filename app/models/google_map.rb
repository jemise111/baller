# This should really be a module

class GoogleMap
  STATIC_URL = "http://maps.google.com/maps/api/staticmap?key=#{ENV["GOOGLE_API_KEY"]}&size=512x512&maptype=roadmap"
  EMBED_URL  = "https://www.google.com/maps/embed/v1/view?key=#{ENV["GOOGLE_API_KEY"]}&zoom=19&maptype=satellite"

  # all methods are untested

  def self.static_map_url(labels, courts)
    result = STATIC_URL
    courts.each_with_index.map do |court, i|
      result << "&markers=label:#{labels[i]}|#{court.latitude},#{court.longitude}"
    end
    result
  end

  def self.embed_map_url(court)
    EMBED_URL + "&center=#{court.latitude}, #{court.longitude}"
  end
end
