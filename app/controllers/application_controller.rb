class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_admin
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin
    current_user.admin if current_user
  end

  def require_authentication
    redirect_to login_path unless current_user
  end

  def require_admin_authentication
    redirect_to login_path unless current_admin # not sure if i can do this
  end
end
