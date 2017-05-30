class Admin::SellerProductsController < ApplicationController
  layout 'admin'
  before_action :find_product,:only => [:edit,:delete]
  def new
    @product=Product.new(product_type_id: Category.find(current_user.category_id).product_type_id)
  end
  
  def create
    @product=current_user.products.new(product_white_list)
    if @product.save
      flash[:notice]=[5000,t('admin.toast.product_create')]
      redirect_to admin_seller_products_path
    else
      render('new') 
    end
  end
  
   def toggle_lock
    @product.update_attribute(:lock,!@product.lock)
    flash[:notice]=[5000,t("admin.toast.page_lock_#{@page.lock}")]
    redirect_to admin_pages_path
  end

  def index
    @products=current_user.products
  end

  def edit
    
  end
  
  def update
  if @product.update_attributes(product_white_list)
  flash[:notice]=[5000,t("admin.toast.product_updated")]
else
  
  render 'edit'
end
end

  def show
  end
    private
    
    def find_product
      @product=Product.find(params[:id])
      
    end

  def product_white_list
    params.require(:product).permit(:category_id,:name, :product_type_id,:price,:off_price,:detail, {images: []}).tap do |whitelisted|
      whitelisted[:properties] = params[:product][:properties]
    end
    end
    
end
