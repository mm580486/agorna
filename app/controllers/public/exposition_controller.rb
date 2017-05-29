class Public::ExpositionController < ApplicationController
  layout 'public'
  def show
    @exposition=User.sellers.find(params[:id])
    @comment=@exposition.comments.new()
    @comments=Comment.where(seller_id: @exposition.id)
  end
  
  def create_comment
unless params[:p_id].nil?
@comment=current_user.comments.new(product_id: params[:p_id],body: params[:comment][:body])
else
    @comment=current_user.comments.new(seller_id: params[:ex_id],body: params[:comment][:body])
end
    if @comment.save
    flash[:notice]=[5000,t('public.toast.comment_created')]
    else
      flash[:notice]=[5000,@comment.errors]
    end
    redirect_to :back
    
  end
  
  def rate
    render text: 'salam'
    
  end
  
  def follow
    if params[:followed]=='false'
      User.find(params[:id]).followers << current_user
    else
      User.find(params[:id]).followers.delete(current_user)
    end
    
    render text: User.find(params[:id]).followers.include?(current_user)
    
  end

  
end
