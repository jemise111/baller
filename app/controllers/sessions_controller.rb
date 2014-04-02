class SessionsController < ApplicationController
  def new
    redirect_to root_path if current_user
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      # This might be buggy. Storing :return_to in session hash when I don't want it to
      # if session[:return_to]
      #   return_path = session[:return_to]
      #   session[:return_to] = nil
      #   redirect_to return_path
      # else
        redirect_to root_path # change this
      # end
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
