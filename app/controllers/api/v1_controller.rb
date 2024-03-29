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
       @categories=Category.where(parent_id: nil) 
    @c=[]

    @categories.each do |category|
        new_field = {"subcategories" => category.subcategories}
        demo = JSON::parse(category.to_json).merge(new_field)
        @c << demo
      end
    render json: @c


    end
    def subcategories
       render json: Category.where(parent_id: params[:id]) 
    end
    
    def expositions
      case params[:type] 
      
      when 'top_rate'
        @expositions=User.sellers
        
        when 'random_expositions'
            @expositions=User.sellers.order("RANDOM()")
      end
     
      
    end
    
    def marketer_sellers
        @marketer=User.find_by_authentication_token(params[:token])
        @expositions=User.where(marketer_id: @marketer.id)
        render 'expositions'
    end
    
    def add_seller
        @marketer=User.find_by_authentication_token(params[:token])
        @form_user=JSON.parse(params[:form_user])
        @exposition=User.new(marketer_id: @marketer.id,name: @form_user['name'],exposition_name: @form_user['exposition_name'],exposition_address: @form_user['exposition_address'],phone: @form_user['phone'],exposition_detail: @form_user['exposition_detail'],telegram: @form_user['telegram'],email: @form_user['email']).save
        render json: @exposition
        
    end
    
    
    def delete_seller
        @marketer=User.find_by_authentication_token(params[:token])
        @exposition=User.find(params[:id]).destroy
        render json: {status: 'ok'}
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
       

      images_params=@form_product['images']
      images=[]
      images=images_params.split('@') unless images_params.nil?
      
    #   render json: params[:images]
      @images=[]
      images.each do |image|
          UserMailer.user_errors('add product',"params: #{images_params} image: #{image}").deliver_now
          
          image= "data:image/jpeg;base64,#{image}"
          @images.append(parse_image_data(image))
      end
       
       
    # #   render json: @images
       
       
      @product=@user.products.new(images: @images,name: @form_product['name'],price: @form_product['price'],off_price: @form_product['off_price'],detail: @form_product['detail'],category_id: @form_product['category_id'],properties: dynamic_field)
        
      
       
    # #   logger.debug "params image: #{params[:images]}"
       
       
       
      if @product.save
          render :json => {status: 'ok',product: @product}, :status => :ok
      else
        render :json => @product.errors#, :status => :bad_request     
      end
      
    
        
    end
    
    
    
def parse_image_data(base64_image)
    filename = rand(1...502).to_s
     in_content_type, encoding, string = base64_image.split(/[:;,]/)[1..3]
    @tempfile = Tempfile.new(filename)
    @tempfile.binmode
    
    @tempfile.write Base64.decode64(string)
    @tempfile.rewind
    
    # "data:image/jpeg;base64,iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6MEVBMTczNDg3QzA5MTFFNjk3ODM5NjQyRjE2RjA3QTkiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6MEVBMTczNDk3QzA5MTFFNjk3ODM5NjQyRjE2RjA3QTkiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDowRUExNzM0NjdDMDkxMUU2OTc4Mzk2NDJGMTZGMDdBOSIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDowRUExNzM0NzdDMDkxMUU2OTc4Mzk2NDJGMTZGMDdBOSIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PjjUmssAAAGASURBVHjatJaxTsMwEIbpIzDA6FaMMPYJkDKzVYU+QFeEGPIKfYU8AETkCYI6wANkZQwIKRNDB1hA0Jrf0rk6WXZ8BvWkb4kv99vn89kDrfVexBSYgVNwDA7AN+jAK3gEd+AlGMGIBFDgFvzouK3JV/lihQTOwLtOtw9wIRG5pJn91Tbgqk9kSk7GViADrTD4HCyZ0NQnomi51sb0fUyCMQEbp2WpU67IjfNjwcYyoUDhjJVcZBjYBy40j4wXgaobWoe8Z6Y80CJBwFpunepIzt2AUgFjtXXshNXjVmMh+K+zzp/CMs0CqeuzrxSRpbOKfdCkiMTS1VBQ41uxMyQR2qbrXiiwYN3ACh1FDmsdK2Eu4J6Tlo31dYVtCY88h5ELZIJJ+IRMzBHfyJINrigNkt5VsRiub9nXICdsYyVd2NcVvA3ScE5t2rb5JuEeyZnAhmLt9NK63vX1O5Pe8XaPSuGq1uTrfUgMEp9EJ+CQvr+BJ/AAKvAcCiAR+bf9CjAAluzmdX4AEIIAAAAASUVORK5CYII="
# 
    # for security we want the actual content type, not just what was passed in
    content_type = `file --mime -b #{@tempfile.path}`.split(";")[0]

    # we will also add the extension ourselves based on the above
    # if it's not gif/jpeg/png, it will fail the validation in the upload model
     extension = content_type.match(/gif|jpeg|png/).to_s
    filename += ".#{extension}" if extension


    ActionDispatch::Http::UploadedFile.new({
      tempfile: @tempfile,
      content_type: content_type,
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
    
    def nearby
        coords=[]
        coords.push params[:latitude]
        coords.push params[:longitude]
        @expositions=User.sellers.near(coords, 5, :order => '')
        
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


  def update_password
   user=User.find_by_authentication_token(params[:token])
   oldPassword=params[:oldPassword]
   newPassword=params[:newPassword]
   if user.valid_password?(oldPassword)
      user.update_attribute(:password,newPassword)
      ok=true
   else
      ok=false
   end

   render json: {ok: ok}
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
    when 'parent_category'
        ids=Category.find(params[:category_id]).subcategories.ids
        @products=Product.where(category_id: ids)
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
         @seener=User.find_by_authentication_token(params[:token]) rescue nil
         @expositions=User.sellers.where("lower(exposition_name) LIKE ? OR lower(name) LIKE ?", "%#{params[:q].downcase}%","%#{params[:q].downcase}%") 
         
       end
       
    end
    def profile
        @user=User.find_by_authentication_token(params[:token])
    end
    
    def update_profile
        @form_user=JSON.parse(params[:form_user])
        @user=User.find_by_authentication_token(params[:token])
        
       if @user.update_attributes(name: @form_user['name'],exposition_name: @form_user['exposition_name'],email: @form_user['email'],phone: @form_user['phone'],static_phone: @form_user['static_phone'],exposition_detail: @form_user['exposition_details'],exposition_address: @form_user['exposition_address'],instagram_id: @form_user['instagram_id'],telegram: @form_user['telegram'],family: @form_user['family'],gender: @form_user['gender'] )
          
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
        @find_tickets=Ticket.where('(user_id = ? OR user_two = ?) OR (user_id = ? OR user_two = ? )',@user.id,params[:id],params[:id],@user.id)
        @exposition_id=params[:id]

        if @find_tickets.size == 0
            t=Ticket.create(user_id: @user.id,user_two: @exposition_id,title: ' ')
            if params[:message].to_s != "undefined"
            Ticketmessages.new(ticket_id: t.id,user_id: @user.id,message: params[:message]).save 
            end
            @ticketmessages = t.ticketmessages.order('id ASC')
        else
            @ticketmessages=@find_tickets.last.ticketmessages.order('id ASC')
        end
        @ticketmessages.update_all(:seen=> true)
        if @user.id == @find_tickets.last.user_id
            @opponent = User.find(@find_tickets.last.user_two)
        else
            @opponent = User.find(@find_tickets.last.user_id)
        end

        @ticketmessages.map {|x| 
        begin
        id=x.message.match(/\$+\d*/)[0]
        product=Product.find(id[1..id.size])
        x.message.gsub!(/\S*\$(\[[^\]]+\]|\S+)/, "<img src='https://www.pinsood.com#{product.images[0].url}' class='#{product.id} product-image' />")
        rescue
        x.message.gsub!(/\S*\$(\[[^\]]+\]|\S+)/,'محصول یافت نشد')
        end
    }
    end
    
    def hasNewTickets
        begin
            @user=User.find_by_authentication_token(params[:token]) 
            @ticketmessages=Ticketmessage.all.where(ticket_id: Ticket.where('user_id = ? OR user_two = ?',@user.id,@user.id).order('id DESC').ids).where.not(user_id: @user.id).where(seen: false)
            count=@ticketmessages.count
            @from=@ticketmessages.pluck(:ticket_id).uniq
            @ticketmessages.update_all(seen: true)
            render json: {size: count,from: @from.size}
        rescue
            render json: {size: 0,form: 0}
            
        end
    end
    
    
    
    def build_conversation

        @user=User.find_by_authentication_token(params[:token])
        if params[:message].to_s != "undefined"
        @ticketmessage=Ticket.where('(user_id = ? OR user_two = ?) OR (user_id = ? OR user_two = ? )',@user.id,params[:id],params[:id],@user.id).first.ticketmessages.build(user_id: @user.id,message: params[:message])
        begin
            id=@ticketmessage.message.match(/\$+\d*/)[0]
            product=Product.find(id[1..id.size])
            @ticketmessage.message.gsub!(/\S*\$(\[[^\]]+\]|\S+)/, "<img src='https://www.pinsood.com#{product.images[0].url}' class='#{product.id} product-image' />")
            rescue
                @ticketmessage.message.gsub!(/\S*\$(\[[^\]]+\]|\S+)/,'محصول یافت نشد')
            end
    
        @ticketmessage.save

        



        else
            return false
        end
    end
    def checkNewMessage
        @user=User.find_by_authentication_token(params[:token])
        @ticketmessages=Ticket.where('(user_id = ? OR user_two = ?) OR (user_id = ? OR user_two = ? )',@user.id,params[:id],params[:id],@user.id).first.ticketmessages.where('id > ?',params[:last_message_id]).order('id ASC')
        @ticketmessages.map {|x| 
        begin
        id=x.message.match(/\$+\d*/)[0]
        product=Product.find(id[1..id.size])
        x.message.gsub!(/\S*\$(\[[^\]]+\]|\S+)/, "<img src='https://www.pinsood.com#{product.images[0].url}' class='#{product.id} product-image' />")
        rescue
        x.message.gsub!(/\S*\$(\[[^\]]+\]|\S+)/,'محصول یافت نشد')
        end
    }
        render 'conversation'
    end
    
    
    def login
        data = JSON.parse(params[:formdata])
        
        begin
            @user=User.find_for_authentication(email: data['email'])
        rescue
            @user=User.find_for_authentication(phone: data['phone'])
        end 
        @user.valid_password?(data['password'])
        render status: :ok,json: @user
    end
    
    
    
    def register

        data = JSON.parse(params[:formdata])
      @user = User.new(:name => data['name'],
                 :email => data['email'],
                 :date => data['date'],
                 :gender => data['gender'],
                 :family => data['family'],
                 :phone => data['phone'],
                 :password => data['password'],
                 :password_confirmation => data['password'])
      if @user.save
         render json: @user, status: :created
     else
         render json: @user.errors,status: :bad_request
      end

    end
    
    
    def register_exposition
        
        user=User.create_with(name: params[:name]).find_or_create_by(phone: params[:phone])
           client=KaveRestApi::SendSimple.new({
            receptor: user.phone, # can be array ['09127105568','09123456789'] < = 3000 
            message: "کد وریفای شما در پین سود
            #{user.verify_code} میباشد
            "
            }).call
            
            
        render json: {status: 200,ex: user}
    end
    
    def register_exposition_c
        @form_user=JSON.parse(params[:form_user])
        user=User.find(@form_user['id'])
        if user.update_attributes(level: 1,exposition_detail: @form_user['detail'],exposition_address: @form_user['address'],category_id: @form_user['category_id'],identify: @form_user['identity'],exposition_name: @form_user['exposition_name'])
            res={status: 200,ex: user}
        else
            res={status: 400,message: user.errors}
        end
        
        render json: res  
    end
    
    
    def verify
        user=User.find_by_authentication_token(params[:token])
        code=params[:code]
        res={}
        
        if user.verify_code == code.to_i
            res={status: 200,message: 'ok'}
            user.update_attribute(:phone_verify,true)
        else
            res={status: 400,message: 'verify code is invalid'}
        end
        render json: res
    end
    
    
    def check_username
       identity=params[:identity] 
        render json: {status: 200,has: User.exists?(identify: identity)}
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
