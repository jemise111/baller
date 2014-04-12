class WelcomeController < ApplicationController
  def index
    @boroughs = Court.pluck(:borough).uniq
  end

  def about
  end
end
