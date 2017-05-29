class Public::ExpositionController < ApplicationController
  layout 'public'
  def show
    @exposition=User.sellers.find(params[:id])
    @products=@exposition.products
    @products=@products.where(category_id: Category.find_by_permalink(params[:category]).id ) if params[:category].present?
    if params[:sort].present?
      sort=(params[:sort]=='asc')? 'ASC':'DESC'
      @products=@products.order(created_at: sort)
    end
    
    
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
     if current_user.voteing.create(vote: params[:vote].to_f,exposition_id: params[:exposition_id])

       user=User.find(params[:exposition_id])
       vote=User.first.votes.sum(:vote).to_f / User.first.votes.size
       render text: vote

    end
    
    
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
