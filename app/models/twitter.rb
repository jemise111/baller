class Twitter

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

    # Parse and print the Tweet if the response code was 200
    tweet = nil

    # Return true for success, false otherwise
    response.code == '200'
  end

end
