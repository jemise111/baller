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
    @user = User.create(user_params)
    @user.update(admin: false)
    redirect_to(@user)
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to root_path unless current_admin
    end
  end

  def update
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to root_path unless current_admin
    end
    @user.update(user_params)
    redirect_to(@user)
  end

  def destroy
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to root_path unless current_admin
    end
    @user.destroy
    session[:user_id] = nil
    redirect_to(users_path)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :zip_code,
                                 :password, :password_confirmation)
  end
end
