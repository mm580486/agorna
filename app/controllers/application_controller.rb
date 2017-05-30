class ApplicationController < ActionController::Base
  layout 'public'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  def is_login
    return !current_user.nil?
  end
  
  def user_login
    unless is_login 
      redirect_to root_path
    end
  end
  
  def admin_auth
    unless is_login 
      redirect_to root_path
    else
      redirect_to root_path unless current_user.level == 3
    end
  end
  
  def admin_and_mekter_auth
    
    unless is_login 
      redirect_to root_path
    else
      redirect_to root_path unless (current_user.level == 3 || current_user.level == 2)
    end
    
  end
  
  def seller_auth
       unless is_login 
      redirect_to root_path
    else
      redirect_to root_path unless current_user.level == 1
    end
    
  end
  
    def add_seller_auth
       unless is_login 
      redirect_to root_path
    else
      redirect_to root_path unless current_user.level == 2
    end
    
  end
  
  def dashboard_auth
       unless is_login 
      redirect_to root_path
    else
      redirect_to root_path unless [1,2,3].include?(current_user.level)
    end
    
  end
  
  def exec_setting
    @setting=Setting.first
  end
  
  
  def check_development_mod
   return true unless @setting.site_down
   if user_signed_in?
    return true if current_user.level == 3  
   end
   redirect_to update_path
    
    
  end
  
  
  
  
end
