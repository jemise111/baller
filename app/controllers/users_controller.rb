class UsersController < ApplicationController
  before_action :require_authentication, only: [:show, :edit, :update, :destroy]
  before_action :require_admin_authentication, only: [:index]

  def index
    @users = User.all
  end

  # can a user view other user's profiles? up for debate
  def show
    @user = User.find(params[:id])
  end

  def new
    # custom authentication
    require_admin_authentication if current_user
    @user = User.new
  end

  def create
    # custom authentication
    require_admin_authentication if current_user
    @user = User.new(user_params)
    @user.update(admin: false, email_display: true)
    if @user.save
      session[:user_id] = @user.id # user is logged in upon creation
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to root_path unless current_admin
    end
  end

  # If password is too short, render edit page again

  def update
    @user = User.find(params[:id])
    # if current_user != @user
    #   redirect_to root_path unless current_admin
    # end
    if @user.update(user_params)
      redirect_to(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user != @user && !current_admin
      redirect_to root_path
    else
      @user.destroy
      session[:user_id] = nil unless current_admin
      redirect_to(users_path)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :zip_code,
                                 :password, :password_confirmation, :notifications)
  end
end
