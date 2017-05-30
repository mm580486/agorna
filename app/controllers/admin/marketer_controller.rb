class Admin::MarketerController < ApplicationController
  layout 'admin'
  before_action :admin_auth
  before_action :find_marketer, except: [:index,:new]
  
  def index
    @users=User.marketers
  end

  def new
    @user=User.new
  end

  def edit
  end

  def show
  end
  def create 
    @user = User.new(marketers_white_list)
    @user.level = 2
    if @user.save
      flash[:notice]=[5000,t('admin.toast.marketer_create')]
      redirect_to admin_marketers_path
    else
      render('new') 
    end  
    
  end
  def destroy
    
    
  end
  
  def delete
    if @user.destroy
      flash[:notice]=[5000,t("admin.toast.RemoveMarketer")]
      redirect_to admin_marketers_path 
    else
      flash[:notice]=[5000,t("admin.toast.cantRemoveMarketer")]
      redirect_to admin_marketers_index_path
    end
  end
  
  
  def update
   if @marketer.update_attributes(marketers_white_list) && @marketer.valid?
      flash[:notice]=[5000,t('admin.toast.marketer_updated')]
      redirect_to admin_marketers_path
   else
     render('edit')
   end
  end
  
  private
  
  def find_marketer
    @user=User.find(params[:id]) rescue ''
  end
  
  def marketers_white_list
   params.require(:user).permit(:email,:name,:phone,:national_code,:password,:password_confirmation) 
  end
  
end
