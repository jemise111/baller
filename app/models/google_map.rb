# This should really be a module

class GoogleMap
  URL = "http://maps.google.com/maps/api/staticmap?size=512x512&maptype=roadmap&key=AIzaSyBUAOr0dXo8Oa5nBuDzLDRXYifbUg1kzqk"

  def self.static_map_url(labels, courts)
    result = URL
    courts.each_with_index.map do |court, i|
      result << "&markers=label:#{labels[i]}|#{court.latitude},#{court.longitude}"
    end
    result
  end
end
