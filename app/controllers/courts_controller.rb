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

  # search could be DRY'd up

  def search
    result = Geocoder.search(params[:q].to_i).first
    latitude = result.latitude
    longitude = result.longitude
    @result_courts = {}
    Court.all.each do |court|
      if court.distance_to(latitude, longitude) < Court::CLOSE_DISTANCE
        @result_courts[court.distance_to(latitude, longitude)] = court
      end
    end
    @labels = ('A'..'Z').to_a
    @marker_coords = ''
    @result_courts.keys.first(26).sort.each_with_index.map do |court_distance, i|
      court = @result_courts[court_distance]
      @marker_coords << "markers=label:#{@labels[i]}|#{court.latitude},#{court.longitude}&"
    end.join('')
    flash.now[:no_results] = 'No courts found'
  end

  private

  def court_params
    params.require(:court).permit(:name, :location, :borough,
                                  :num_courts, :latitude, :longitude)
  end
end
