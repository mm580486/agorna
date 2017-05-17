class Admin::PagesController < ApplicationController
  layout 'admin'
  before_action :admin_auth
  before_action :find_page, only: [:show,:edit,:destroy,:delete,:update,:toggle_lock]
  
  
  def index
    @pages = Page.page(params[:page]).paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def destroy
  end

  def edit
  end
  
  def toggle_lock
    @page.update_attribute(:lock,!@page.lock)
    flash[:notice]=[5000,t("admin.toast.page_lock_#{@page.lock}")]
    redirect_to admin_pages_path
  end
  
  def update
   if @page.update_attributes(page_white_list) && @page.valid?
      flash[:notice]=[5000,t('admin.toast.page_updated')]
      redirect_to admin_pages_path
   else
     render('edit')
   end
  end
  
  def delete
     if @page.destroy
      flash[:notice]=[5000,t('admin.toast.page_deleted')]
      redirect_to admin_pages_path
    else
      flash[:notice]=[5000,@page.errors]
      redirect_to admin_pages_path
    end
    
  end

  def new
    @page = current_user.pages.new 
  end
  
  def create
    @page = current_user.pages.new(page_white_list)
    if @page.save
      flash[:notice]=[5000,t('admin.toast.page_create')]
      redirect_to admin_pages_path
    else
      render('new') 
    end
  end
  
  private
  
  def find_page
    @page = Page.find(params[:id])
  end
  
  def page_white_list
    params.require(:page).permit(:title,:permalink,:comment,:content,:tag,:layout)
  end
  
end
