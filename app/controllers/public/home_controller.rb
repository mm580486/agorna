class Public::HomeController < ApplicationController
    layout 'public'
    before_action :exec_setting
    before_action :check_development_mod,except: :update
    
    def reset_password
       if User.exists?(phone: params[:phone])
           @user=User.find_by_phone(params[:phone])
           password=rand(10000000...99999999)
           @user.update_attributes(password: password,password_confirmation: password)
           
           client=KaveRestApi::SendSimple.new({
            receptor: @user.phone, # can be array ['09127105568','09123456789'] < = 3000 
            message: "رمز عبور شما در پین سود
            #{password}
            "
            }).call
            flash[:notice]=[5000,'رمز عبور جدید ارسال شد']
            redirect_to :back
       else
                 flash[:notice]=[5000,'کاربری با این شماره وجود ندارد']
            redirect_to :back 
       end
        
        
    end
    
    def index
        @products=Product.all.limit(8)
        @expositions=User.sellers.limit(8)
        @categories = Category.where(parent_id: nil)
    end
    
    def update
      UserMailer.welcome_email(User.first).deliver_later
    end
    
    def category
      @categories = Category.where(parent_id: nil)  
      @products=Product.where(category_id: Category.find_by_permalink(params[:permalink]).id )
    end
    
    def register_exposition
        @user = User.new
    end
    
    def following
        @expositions = current_user.following
    end
    
    def following_post
        @products = Product.where(user_id: current_user.following)
    end
    
    def product
        @comment=Comment.new
        @product=Product.find(params[:id])
        @exposition=@product.user
    end
    def favorite
        begin 
    if params[:liked]=='false'
      current_user.favorites.build(product_id: params[:id]).save
    else
      current_user.favorites.find_by(product_id: params[:id]).delete
    end
    rescue 
    
    end
    render text: current_user.favorites.exists?(product_id: params[:id])
    
    
    
    end
    def favorites
       @products=current_user.favorite_produts
    end
    
    def search 
       if params[:type]=='product'
           @products = Product.where("lower(name) LIKE ?", "%#{params[:q].downcase}%")
       else
           @expositions=User.sellers.where("lower(exposition_name) LIKE ? OR lower(name) LIKE ?", "%#{params[:q].downcase}%","%#{params[:q].downcase}%") 
       end
    end
    
    
    def save_exposition
        @user = User.new(exposition_white_list)
        @user.level = 1
        if @user.save
            UserMailer.welcome_email(@user).deliver_now
            redirect_to root_path
        else 
            render 'register_exposition'
        end
    end
    
    
    def page
       @page=Page.find_by_permalink(params[:permalink]) 
    end
    
    
    
    private
    
    def exposition_white_list
        params.require(:user).permit(:password,:password_confirmation,:static_phone,:avatar,:background_image,:category_id,:email,:name,:phone,:exposition_name,:exposition_detail,:exposition_address,:instagram,:telegram,:post_service)
    end
    
    
    
    
end
