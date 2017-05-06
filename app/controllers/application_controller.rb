class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  def is_login
    return !current_user.nil?
  end
  
  def admin_auth
    unless is_login 
      redirect_to root_path
    else
      redirect_to root_path unless current_user.level == 3
    end
  end
  
  
  
  
end
