class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :admin_and_seller_auth
  before_action :find_comment, :only => [:show,:delete,:toggle_lock]
  
  
  def index
    @comments = Comment.all
    
  end

  def toggle_lock
    @comment.update_attribute(:accept,!@comment.accept)
    flash[:notice]=[5000,t("admin.toast.comment_lock_#{@comment.accept}")]
    redirect_to admin_comments_path
  end
  
  def delete
     if @comment.destroy
      flash[:notice]=[5000,t('admin.toast.comment_deleted')]
      redirect_to admin_comments_path
    else
      flash[:notice]=[5000,@comment.errors]
      redirect_to admin_comment_path
    end
    
  end

  private
  
  def find_comment
    @comment = Comment.find(params[:id])
  end

end
