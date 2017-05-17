class Admin::DashboardController < ApplicationController
  before_action :dashboard_auth
  before_action :admin_auth ,only: [:change_development_mode]
  layout 'admin'
  def index
  end
  
  def setting
    
    
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
end
