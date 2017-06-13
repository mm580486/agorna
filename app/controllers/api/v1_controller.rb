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
    
    def show_exposition
       render json: User.sellers.find(params[:id]) 
    end
    
    def products
     case params[:type] 
      when 'last_products'
        @products=Product.all
      when 'category'
        @products=Product.where(category_id: params[:category_id])
      when 'favorites'
        @products=Product.all
      end
      
    end
    def profile
        @user=User.find_by_authentication_token(params[:token])
    end
    
    def update_profile
        @form_user=JSON.parse(params[:form_user])
        @user=User.find_by_authentication_token(params[:token])
        render @form_user
        # @user.update_attributes(name: @form_user.name,exposition_name: @form_user.exposition_name,email: @form_user.email,phone: @form_user.phone,static_phone: @form_user.static_phone,exposition_detail: @form_user.exposition_details,exposition_address: @form_user.exposition_address,instagram_id: @form_user.instagram_id,telegram: @form_user.telegram  )
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
