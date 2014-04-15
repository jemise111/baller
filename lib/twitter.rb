module Twitter

  def self.send_tweet(content, lat, lon)
    consumer_key = OAuth::Consumer.new(
      ENV["TWITTER_CONSUMER_KEY"],
      ENV["TWITTER_CONSUMER_SECRET"])
    access_token = OAuth::Token.new(
      ENV["TWITTER_ACCESS_TOKEN"],
      ENV["TWITTER_ACCESS_SECRET"])
    baseurl = "https://api.twitter.com"
    path    = "/1.1/statuses/update.json"
    address = URI("#{baseurl}#{path}")
    request = Net::HTTP::Post.new address.request_uri
    request.set_form_data(
      "status" => content,
      "lat" => lat,
      "long" => lon,
      "display_coordinates" => true
    )
    # Set up HTTP.
    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Issue the request.
    request.oauth! http, consumer_key, access_token
    http.start
    response = http.request request

    # Return true for success, false otherwise
    response.code == '200'
  end

  # untested
  def self.random_tweet_content(time_info, court_name, court_id)
    ["New pick up game on #{time_info} at #{court_name}. Wanna ball? http://ballernycco.com/courts/#{court_id}",
     "Ready to ball? Game on #{time_info} at #{court_name}. http://ballernycco.com/courts/#{court_id}",
     "Break in them new kicks on #{time_info} at #{court_name}. http://ballernycco.com/courts/#{court_id}"].sample
  end

end
