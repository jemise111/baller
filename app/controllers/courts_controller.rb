class CourtsController < ApplicationController

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
end
