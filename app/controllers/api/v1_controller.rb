class Api::V1Controller < ApplicationController
    before_filter :add_allow_credentials_headers
    skip_before_action :verify_authenticity_token
    def add_allow_credentials_headers                                                                                                                                                                                                                                                        
      # https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS#section_5                                                                                                                                                                                                      
      #                                                                                                                                                                                                                                                                                       
      # Because we want our front-end to send cookies to allow the API to be authenticated                                                                                                                                                                                                   
      # (using 'withCredentials' in the XMLHttpRequest), we need to add some headers so                                                                                                                                                                                                      
      # the browser will not reject the response                                                                                                                                                                                                                                             
      response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'                                                                                                                                                                                                     
      response.headers['Access-Control-Allow-Credentials'] = 'true'  
      response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'  
       
    end 


    def categories
       render json: Category.where(parent_id: nil) 
    end
    def subcategories
       render json: Category.where(parent_id: params[:id]) 
    end
    
    def expositions
      case params[:type] 
      
      when 'top_rate'
        @expositions=User.sellers
      end
     
      render json: @expositions
    end
    
    def exposition
        @user=User.find(params[:id])
    end
    
    def product_categories
       @user=User.find_by_authentication_token(params[:token]) 
       render json: Category.where(parent_id: @user.category_id)
    end
    
    def slider
        
        render json: @setting.mobile_slider
    end
    
    def category_fields
       @user=User.find_by_authentication_token(params[:token]) 
       render json: ProductType.find(Category.find(@user.category_id).product_type_id).fields.where("'#{params[:category_id]}' = ANY (categories)")
    end
    
    def save_product
       @user=User.find_by_authentication_token(params[:token]) 
       @form_product=JSON.parse(params[:form_product])
       dynamic_field={}
       ProductType.find(Category.find(@user.category_id).product_type_id).fields.where("'#{@form_product['category_id']}' = ANY (categories)").each do |field|
          dynamic_field[field.name]= @form_product[field.permalink]
       end
       @product=@user.products.new(name: @form_product['name'],price: @form_product['price'],off_price: @form_product['off_price'],detail: @form_product['detail'],category_id: @form_product['category_id'],properties: dynamic_field)
       if @product.save
           render :json => {status: 'ok'}, :status => :ok
       else
        render :json => @product.errors, :status => :bad_request     
       end
        
    end
    
    def show_exposition
       render json: User.sellers.find(params[:id]) 
    end
    
    def products
     case params[:type] 
      when 'last_products'
        @products=Product.all
      when 'category'
        @products=Product.where(category_id: params[:category_id])
      when 'self'
          @user=User.find_by_authentication_token(params[:category_id])
          @products=@user.products
      when 'favorites'
        @products=Product.all
      end
      
    end
    
    
    def delete_product
       @user=User.find_by_authentication_token(params[:token]) 
       @product=@user.products.find(params[:product_id])
       @product.destroy
       
       render json: @user.products
        
    end
    
    
    def search
        if params[:type]=='product'
           
           render json: Product.all.where("lower(name) LIKE ?", "%#{params[:q].downcase}%")
       else
         render json: User.sellers.where("lower(exposition_name) LIKE ? OR lower(name) LIKE ?", "%#{params[:q].downcase}%","%#{params[:q].downcase}%") 
         
       end
       
    end
    def profile
        @user=User.find_by_authentication_token(params[:token])
    end
    
    def update_profile
        @form_user=JSON.parse(params[:form_user])
        @user=User.find_by_authentication_token(params[:token])
        
       if @user.update_attributes(name: @form_user['name'],exposition_name: @form_user['exposition_name'],email: @form_user['email'],phone: @form_user['phone'],static_phone: @form_user['static_phone'],exposition_detail: @form_user['exposition_details'],exposition_address: @form_user['exposition_address'],instagram_id: @form_user['instagram_id'],telegram: @form_user['telegram']  )
          
          render :json => @user, :status => :ok
          
      else
          
          render :json => @user.errors, :status => :bad_request
       end
    end
    
    def save_comment
        @user=User.find_by_authentication_token(params[:token])
        @product=Product.find(params[:id])
        if @product.comments.build(body: params[:content],user_id: @user.id).save
            render json: {status: :ok}
        else
            render nothing: true,status: 204 ,json: {}
        end
        
    end
    def favorites
        @products=Product.all
        render 'products'
    end
    def product
        @product=Product.find(params[:id])
    end
    
    def product_comments
        @comments=Product.find(params[:id]).comments
    end
    
    def tickets
        @user=User.find_by_authentication_token(params[:token])
        @tickets=Ticket.where('user_id = ? OR user_two = ?',@user.id,@user.id).order('id DESC')
    end
    
    def conversation
        @user=User.find_by_authentication_token(params[:token])
        @ticketmessages=Ticket.find(params[:id]).ticketmessages.order('id ASC')
    end
    
    def hasNewTickets
        @user=User.find_by_authentication_token(params[:token])
        @tickets=Ticket.where('user_id = ? OR user_two = ?',@user.id,@user.id).order('id DESC')
        
    end
    
    
    
    def build_conversation
        @user=User.find_by_authentication_token(params[:token])
        @ticketmessage=Ticket.find(params[:id]).ticketmessages.build(user_id: @user.id,message: params[:message])
        @ticketmessage.save
        
    end
    def checkNewMessage
        @user=User.find_by_authentication_token(params[:token])
        @ticketmessages=Ticket.find(params[:id]).ticketmessages.where('id > ?',params[:last_message_id]).order('id ASC')
        render 'conversation'
    end
    
    
    def login
        data = JSON.parse(params[:formdata])
        @user=User.find_for_authentication(email: data['email'])
        @user.valid_password?(data['password'])
        render status: :ok,json: @user
    end
    
    
    
    def register

        data = JSON.parse(params[:formdata])
        
        
      @user = User.new(:name => data['name'],:email => data['email'],
                 :password => data['password'],
                 :password_confirmation => data['password'])
      if @user.save
         render json: @user, status: :created
     else
         render json: @user.errors,status: :bad_request
      end

    end
    
    
    
    def checkAuthentication
        @hyperuser=User.find_by_authentication_token(request.headers["Authorization"])
		if @hyperuser.nil?
		    render status: :gone
        else
            render status: :ok
        end
    end
    
    private 
    
    def profile_white_list
        
    end
    
end
