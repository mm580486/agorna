class Admin::DashboardController < ApplicationController
  before_action :dashboard_auth
  before_action :admin_auth ,only: [:change_development_mode,:sms_service]
  layout 'admin'
  
  def index
  end
  
  def setting
    @setting=Setting.first
  end
  
  def update_setting
    Setting.first.update_attributes(setting_white_list)
    flash[:notice]=[5000,t("admin.toast.setting_updated")]
    redirect_to :back
  end
  
  def profile
    @user=current_user
  end 
  
  def password
    
    
  end
  
  def update_password
        unless params[:password]==params[:password_confirmation]
      flash[:notice]=[5000,'رمزعبور با هم هماهنگ نیست']
      redirect_to :back
    end
    
    if current_user.valid_password?(params[:old_password])
      
  
      
      current_user.update_attributes(password: params[:password],password_confirmation: params[:password_confirmation])
      flash[:notice]=[5000,t("admin.toast.password_updated")]
      redirect_to :back
    else
      
      flash[:notice]=[5000,t("admin.toast.password_inccorect")]
      redirect_to :back
    end
  end
  
  def update_profile
  
    @user = current_user
    if @user.update_attributes(user_white_list)
    flash[:notice]=[5000,t("admin.toast.profile_updated")]
    redirect_to :back
  else
    render('profile')
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
  
  
  def ads
    
    
  end
  
  def send_ads
    current_user.followers.each do |user|
    @ticket=Ticket.new(title: params[:title])
    @ticket.user_id=current_user.id
    @ticket.user_two=user.id
    @ticket.save
    @ticket.ticketmessages.new(message: params[:message],user_id: current_user.id).save
    end
    redirect_to :back
  end
  private
  
  def user_white_list
    params.require(:form_user).permit(:name,:email,:phone,:password,:password_confirmation,:exposition_name,:exposition_address,:instagram,:telegram,:post_service)
  end
  
  def setting_white_list
    params.require(:setting).permit(:site_name,:seo_description,:site_logo,:default_image_product,:default_image_exposition, {site_slider: []}, {mobile_slider: []})
  end
  
end
