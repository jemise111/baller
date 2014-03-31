class CourtsController < ApplicationController

  before_action :require_authentication, only: [:show]
  before_action :require_admin_authentication, only: [:admin_index, :new, :create, :update, :edit, :destroy]

  # Keep under minimum for courts in Staten Island
  MAX_TO_DISPLAY = 25

  def index
    @boroughs = Court.pluck(:borough).uniq
    @courts = Court.all
    unless params[:b].nil?
      courts_in_borough = Court.where(borough: params[:b])
      @display_courts = courts_in_borough.limit(MAX_TO_DISPLAY).offset((params[:p].to_i - 1) * 25)
      @pages = courts_in_borough.size / MAX_TO_DISPLAY + 1
    end
  end

  def show
    @court = Court.find(params[:id])
  end

  # ============= Admin Tools ================

  def new
    @court = Court.new
  end

  def create
    @court = Court.create(court_params)
    redirect_to @court
  end

  def edit
    @court = Court.find(params[:id])
  end

  def update
    @court = Court.find(params[:id])
    @court.update(court_params)
    redirect_to courts_path
  end

  def destroy
      @user = User.find(params[:id])
    @user.destroy
  end

  def admin_index
    @courts = Court.all
  end

  def search
    result = Geocoder.search(params[:q].to_i).first
    lat_long = [result.latitude, result.longitude]
    @result_courts = Court.all.select do |court|
      coorDist(court.latitude, court.longitude, lat_long[0], lat_long[1]) < Court::CLOSE_DISTANCE
    end
    flash.now[:no_results] = 'No courts found'
  end

  private

  def court_params
    params.require(:court).permit(:name, :location, :borough,
                                  :num_courts, :latitude, :longitude)
  end

  def coorDist(lat1, lon1, lat2, lon2)
    earthRadius = 6371 # Earth's radius in KM

        # convert degrees to radians
        def convDegRad(value)
          unless value.nil? or value == 0
                value = (value/180) * Math::PI
          end
        return value
        end

    deltaLat = (lat2-lat1)
    deltaLon = (lon2-lon1)
    deltaLat = convDegRad(deltaLat)
    deltaLon = convDegRad(deltaLon)

    # Calculate square of half the chord length between latitude and longitude
    a = Math.sin(deltaLat/2) * Math.sin(deltaLat/2) +
        Math.cos((lat1/180 * Math::PI)) * Math.cos((lat2/180 * Math::PI)) *
        Math.sin(deltaLon/2) * Math.sin(deltaLon/2);

    # Calculate the angular distance in radians
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

    distance = earthRadius * c

    return distance
  end
end
