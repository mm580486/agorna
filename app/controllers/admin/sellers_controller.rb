class Admin::SellersController < ApplicationController
  layout 'admin'
  before_action :admin_auth
  before_action :find_seller, :only => [:edit, :delete, :show,:toggle_lock]
  
  def index
    if current_user.level == 2
      return @user=current_user.marketer_subscribers
    end
    
    if params[:unaccept]=='true'
      @users=User.sellers.where(:exposition_accept => false)
    else
      @users=User.sellers
    end
    
    
    
  end
  
  
  def toggle_lock
   if @user.update_attribute(:exposition_accept,!@user.exposition_accept)
    flash[:notice]=[5000,t("admin.toast.seller_accepted_#{@user.exposition_accept}")]
  else
    
    flash[:notice]=[5000,@user.errors]
  end
    redirect_to :back
    
  end
  
  def new 
    @user=User.new
  end
  
  def create 
    @user = User.new(seller_white_list)
    @user.level = 1
    @user.marketer_id=current_user.id
    
    if @user.save
      flash[:notice]=[5000,t('admin.toast.seller_create')]
      redirect_to admin_sellers_path
    else
      render('new') 
    end  
    
  end
  
   def update
   if @user.update_attributes(marketers_white_list) && @user.valid?
      flash[:notice]=[5000,t('admin.toast.seller_updated')]
      redirect_to admin_sellers_path
   else
     render('edit')
   end
  end

  def edit
  end

  def show
  end
  
  
  def delete
      @user.destroy
      flash[:notice]=[5000,t('admin.toast.seller_removed')]
      redirect_to admin_sellers_path
  end
  
  
  private
  
  def find_seller
    @user= User.find(params[:id])
  end
  
  def seller_white_list
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
