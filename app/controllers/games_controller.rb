class GamesController < ApplicationController
  before_action :require_authentication
  before_action :require_admin_authentication, only: [:index, :edit, :update, :destroy]

  def index
    # admin tool
    @past_games = Game.all.keep_if { |g| g.past? }
    @future_games = Game.all - @past_games
  end

  def new
    @court = Court.find(params[:court_id])
    @game = @court.games.new
  end

  def create
    @game = Court.find(params[:court_id]).games.new(game_params)
    if @game.save
      @game.update(creator_id: session[:user_id])
      @game.send_game_tweet
      @game.users << User.find(session[:user_id])
      redirect_to @game.court
    else
      @court = Court.find(params[:court_id])
      render 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.update(game_params)
    redirect_to @game.court
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to :back
  end

  def remove_current
    game = Game.find(params[:id])
    if game.past?
      redirect_to :back
    else
      game.users.delete(current_user)
      game.save
      redirect_to :back
    end
  end

  def add_current
    game = Game.find(params[:id])
    game.users << current_user
    game.save
    game.users.each do |user|
      user.send_game_email(game) unless user == current_user
    end
    redirect_to :back
  end

  def players
    # admin tool
    @game = Game.find(params[:id])
  end

  def remove_player
    # admin tool
    @game = Game.find(params[:game_id])
    @user = User.find(params[:id])
    @game.users.delete(@user)
    redirect_to :back
  end

  private

  def game_params
    params.require(:game).permit(:start_at, :capacity, :skill_level)
  end
end
