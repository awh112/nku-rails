class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login
  
  def current_user
    @current_user ||= Student.find(session[:user_id]) if session[:user_id]
  end
  
  private 
  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this page"
      redirect_to login_path # halts request cycle
    end
  end
  
  helper_method :current_user
end
