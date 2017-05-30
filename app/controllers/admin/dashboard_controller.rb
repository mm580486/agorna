class Admin::DashboardController < ApplicationController
  before_action :dashboard_auth
  before_action :admin_auth ,only: [:change_development_mode,:sms_service]
  layout 'admin'
  def index
  end
  
  def setting
    
    
  end
  
  def profile
    @user=current_user
  end 
  
  def update_profile
    @user = current_user
    if @user.update_attributes(user_white_list)
      
    end
  end
  
  def change_development_mode
    @setting = Setting.first
    if @setting.update_attribute(:site_down,params[:development_mod])
      render text: t("admin.toast.development_mod_#{@setting.site_down}")
    else
       render text: @setting.errors
    end
  end

  def login
  end

  def logout
  end
  
  def sms_service
    
  end
  
  def transaction
    
    
  end
  private
  
    def user_white_list
    params.require(:user).permit(
      :name,
      :email,
      :phone,
      :password,
      :password_confirmation,
      :exposition_name,
      :exposition_address,
      :instagram,
      :telegram,
      :post_service
    )
  end
  
end
