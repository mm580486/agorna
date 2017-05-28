class Admin::ProductsController < ApplicationController
  layout 'admin'
  before_action :admin_auth
  before_action :find_product, :only => [:show,:edit,:destroy,:delete,:update,:toggle_lock]
  
    def index
       if params[:unaccept]=='true'
         @products=Product.where(:accept => false)
       else
         @products=Product.all 
       end
    end
    
    def toggle_lock
         if @product.update_attribute(:accept,!@product.accept?)
    flash[:notice]=[5000,t("admin.toast.product_accepted_#{@product.accept?}")]
  else
    
    flash[:notice]=[5000,@product.errors]
  end
    redirect_to :back
    
    
    end
    
    def delete
    if @product.destroy
      flash[:notice]=[5000,t('admin.toast.product_deleted')]
      redirect_to admin_pages_path
    else
      flash[:notice]=[5000,@product.errors]
      redirect_to admin_pages_path
    end
    end
    
    private 
    
    def product_white_list
      params.require(:product).permit(:name,:price)
    end
    
    def find_product
      @product=Product.find(params[:id])
    end
    
end
