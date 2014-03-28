class CourtsController < ApplicationController

  before_action :require_authentication, only: [:show]
  before_action :require_admin_authentication, only: [:new, :create, :update, :edit, :destroy]

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

  private

  def court_params
    params.require(:court).permit(:name, :location, :borough
                                  :num_courts, :latitude, :longitude)
  end
end
