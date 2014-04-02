class Game < ActiveRecord::Base
  # set up dependency?
  has_and_belongs_to_many(:users)
  belongs_to(:court)

  def self.send_new_game_tweet(tweet_content, tweet_lat, tweet_long)
    # Codecademy guidelines
    consumer_key = OAuth::Consumer.new(
      "kINQL7aiSi1OnxOnLYooQ",
      "LSr1FcWkDih2eaDvjlpVT2x8g1yJkPJdBUV22lKIGew")
    access_token = OAuth::Token.new(
      "2422741176-C8ptR5R91TZczahW7C9U5Dc0Yy84YKKSVZvpkKM",
      "tHov86RU5nbEqoucs9iuiLjOb4Q5njKRqdsIw71NeShrD")
    baseurl = "https://api.twitter.com"
    path    = "/1.1/statuses/update.json"
    address = URI("#{baseurl}#{path}")
    request = Net::HTTP::Post.new address.request_uri
    request.set_form_data(
      "status" => tweet_content,
      "lat" => tweet_lat,
      "long" => tweet_long,
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

  def past?
    start_at < (Time.now - 24*60*60).to_datetime
  end
end
