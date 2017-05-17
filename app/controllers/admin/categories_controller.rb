class Admin::CategoriesController < ApplicationController
  layout 'admin'
  before_action :admin_auth
  before_action :find_category, only: [:show,:edit,:destroy,:delete,:update,:toggle_lock]
  
  
  def index
    @categories = Category.where(:parent_id => nil)
  end

  def edit
  end
  
  def update
   if @category.update_attributes(category_white_list) && @category.valid?
      flash[:notice]=[5000,t('admin.toast.category_updated')]
      redirect_to admin_categories_path
   else
     render('edit')
   end
  end

  def new
    @category = current_user.categories.new(parent_id: params[:parent_id])
  end
  
  def create
      @category = current_user.categories.new(category_white_list)
    if @category.save
      flash[:notice]=[5000,t('admin.toast.category_create')]
      redirect_to admin_categories_path
    else
      render('new') 
    end
  
  end
  
    def delete
     if @category.destroy
      flash[:notice]=[5000,t('admin.toast.category_deleted')]
      redirect_to admin_categories_path
    else
      flash[:notice]=[5000,@page.errors]
      redirect_to admin_categories_path
    end
    
  end

  def show
    @categories=@category.subcategories
  end
  
  private
  
  def find_category
    @category = Category.find(params[:id])
  end
  
  def category_white_list
    params.require(:category).permit(:name,:permalink,:parent_id)
  end
  
end
