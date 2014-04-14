class SessionsController < ApplicationController
  def new
    redirect_to root_path if current_user
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      # Following line is buggy. If user is redirected to login page, leaves
      # site, comes back, clicks login, they will be taken to page before redirect.
      redirect_to session.delete(:return_to) || root_path
    else
      flash.now[:login_error] = 'Invalid email and/or password'
      render 'new'
    end
  end

  def destroy
    flash[:auth_error] = nil
    session[:user_id] = nil
    redirect_to login_path
  end
end
