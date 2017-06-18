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
        @seener=User.find_by_authentication_token(params[:token]) rescue nil
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
       @fields=ProductType.find(Category.find(@user.category_id).product_type_id).fields.where("'#{params[:category_id]}' = ANY (categories)")
    end
    
    def save_product
       @user=User.find_by_authentication_token(params[:token]) 
       @form_product=JSON.parse(params[:form_product])
       dynamic_field={}
       ProductType.find(Category.find(@user.category_id).product_type_id).fields.where("'#{@form_product['category_id']}' = ANY (categories)").each do |field|
          dynamic_field[field.name]= @form_product[field.permalink]
       end
       
       images=params[:images].split('@')
       
       @images=[]
       images.each do |image|
           @images.append parse_image_data(image)
       end
       
      @product=@user.products.new(images: @images,name: @form_product['name'],price: @form_product['price'],off_price: @form_product['off_price'],detail: @form_product['detail'],category_id: @form_product['category_id'],properties: dynamic_field,images: @form_product['images'])
        
      
       
       logger.debug "params image: #{params[:images]}"
       
       
       
       if @product.save
           render :json => {status: 'ok',product: @product}, :status => :ok
       else
        render :json => @product.errors, :status => :bad_request     
       end
      
    
        
    end
    
    
    
     def parse_image_data(base64_image)
    filename = "upload-image"
    in_content_type, encoding, string = base64_image.split(/[:;,]/)[1..3]

    @tempfile = Tempfile.new(filename)
    @tempfile.binmode
    @tempfile.write File.open(Base64.decode64(string)).read
    @tempfile.rewind

    # for security we want the actual content type, not just what was passed in
    content_type = `file --mime -b #{@tempfile.path}`.split(";")[0]

    # we will also add the extension ourselves based on the above
    # if it's not gif/jpeg/png, it will fail the validation in the upload model
    extension = content_type.match(/gif|jpeg|png/).to_s
    filename += ".#{extension}" if extension

    ActionDispatch::Http::UploadedFile.new({
      tempfile: @tempfile,
      type: content_type,
      filename: filename
    })
  end

  def clean_tempfile
    if @tempfile
      @tempfile.close
      @tempfile.unlink
    end
  end
  
  
    
    def save_product_image
        @product=Product.find(params[:id])
        @product.update_attribute(:images,params[:file])
        logger.debug "params image: #{params[:file]}"

    end
    
    def exposition_filters
       @exposition=User.find(params[:id])
       @products=@exposition.products
       @categories=Category.where(parent_id: @exposition.category_id)
       @categories=@categories.where(id: @products.pluck(:category_id))
       @dynamic_filters=ProductType.find(Category.find(@exposition.category_id).product_type_id).fields.where(field_type: 'select_box') 
       
    end
    
    
    def filter
       @exposition=User.find(params[:id])
       @products=@exposition.products
       @form_data=JSON.parse(params[:filter_form])
       @products=@products.where(category_id: Category.find_by_permalink(@form_data['category']).id ) if @form_data['category'].present?
       @products=@products.where.not(off_price: '' ) if @form_data['off_price'].present?
    
    
      ids=[]
      dynamic_field={}
      ProductType.find(Category.find(@exposition.category_id).product_type_id).fields.each do |field|
          dynamic_field[field.name]= Prop.find_by_permalink(@form_data[field.permalink]).name  if @form_data[field.permalink].present?
        
       end
       
       dynamic_field.each do |k,v|
           ids.append @products.where(Product.arel_table[:properties].matches("%#{k}: #{v}%")).ids 
       end
       
       @products=@products.where(id: ids) unless ids.blank?
       
       render 'products'
    end
    
   def follow
       @user=User.find_by_authentication_token(params[:token])
    if params[:followed]=='false'
      User.find(params[:id]).followers << @user
    else
      User.find(params[:id]).followers.delete(@user)
    end
    
    render text: User.find(params[:id]).followers.include?(@user)
    
  end
  
    def show_exposition
       render json: User.sellers.find(params[:id]) 
    end
    
    def products
        @user=User.find_by_authentication_token(params[:token]) rescue nil
        
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
        
      when 'exposition_products'
        @exposition=User.find(params[:exposition_id])
        @products=@exposition.products
          
      end
      
    end
    
def favorite
    @user=User.find_by_authentication_token(params[:token])
        begin 
    if params[:favorited]=='false'
      @user.favorites.build(product_id: params[:product_id]).save
    else
      @user.favorites.find_by(product_id: params[:product_id]).delete
    end
    rescue 
    
    end
    render text: @user.favorites.exists?(product_id: params[:id])
    
    
    
    end
    
    
    def exposition_comments
    @exposition=User.sellers.find(params[:id])
    @comments=Comment.where(seller_id: @exposition.id)
        render 'product_comments'
    end
    
    
    def delete_product
       @user=User.find_by_authentication_token(params[:token]) 
       @product=@user.products.find(params[:product_id])
       @product.destroy
       
      @products=@user.products
        render 'products'
    end
    
    
    def search
        if params[:type]=='product'
           
         @products=Product.all.where("lower(name) LIKE ?", "%#{params[:q].downcase}%")
       else
         @expositions=User.sellers.where("lower(exposition_name) LIKE ? OR lower(name) LIKE ?", "%#{params[:q].downcase}%","%#{params[:q].downcase}%") 
         
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
        
        @product=Product.find(params[:id]) if params[:exposition_id].blank? 
        
       
       Comment.new(seller_id: params[:exposition_id],user_id: @user.id,body: params[:content]).save unless params[:exposition_id].blank?
      render json: {status: :ok,type: 'exposition'} unless params[:exposition_id].blank?
       return true unless params[:exposition_id].blank?
        if Comment.new(product_id: params[:id],user_id: @user.id,body: params[:content]).save
            render json: {status: :ok,type: 'product'}
        else
            render nothing: true,status: 204 ,json: {}
        end
        
    end
    def favorites
        @user=User.find_by_authentication_token(params[:token]) rescue nil
        @products=@user.favorite_produts
        render 'products'
    end
    def product
        @product=Product.find(params[:id])
        @user=User.find_by_authentication_token(params[:token]) rescue nil
    end
    
    def startmessage
        @user=User.find_by_authentication_token(params[:token])
        @exposition=User.find(params[:id])
        
        @ticket=Ticket.new(title: params[:title])
        @ticket.user_id=@user.id
        @ticket.user_two=@exposition.id
        
        @ticket.ticketmessages.build(user_id: @user.id,message: params[:body])
        
        @ticket.save
        
        render json: @ticket
    end
    
    def following
        @user=User.find_by_authentication_token(params[:token])
        @users=@user.following
        
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
