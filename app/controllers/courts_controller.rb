class CourtsController < ApplicationController

  before_action :require_admin_authentication, only: [:admin_index, :new, :create, :update, :edit, :destroy]

  # Keep under minimum for courts in Staten Island
  MAX_TO_DISPLAY = 25

  def index
    @boroughs = Court.pluck(:borough).uniq
    @courts = Court.all
    # A lot of logic here but feels like this belongs in controller
    unless params[:b].nil?
      courts_in_borough = Court.where(borough: params[:b])
      @display_courts = courts_in_borough.limit(MAX_TO_DISPLAY).offset((params[:p].to_i - 1) * 25)
      @pages = courts_in_borough.size / MAX_TO_DISPLAY + 1
    end
  end

  def show
    @court = Court.find(params[:id])
    @map_url = GoogleMap.embed_map_url(@court)
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
    # @result_courts is a hash. { distance_to_court => court }
    courts = Court.zip_code_search(params[:q].to_i)
    @labels = ('A'..'Z').to_a
    @result_courts = courts.values.sort { |a, b| courts.key(a) <=> courts.key(b) }.first(26)
    @map_url = GoogleMap.static_map_url(@labels, @result_courts)
    flash.now[:no_results] = 'No courts found'
  end

  private

  def court_params
    params.require(:court).permit(:name, :location, :borough,
                                  :num_courts, :latitude, :longitude)
  end
end
