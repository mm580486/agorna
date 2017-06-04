class RegistrationsController < Devise::RegistrationsController
 
 
 
   def create
    build_resource(registration_params)
    if resource.save
      UserMailer.welcome_email(resource).deliver_now
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        respond_with resource, :location => after_sign_up_path_for(resource)
      end
      
    else
      clean_up_passwords
      respond_with resource
    end
  end  


  
 
 
  def update_resource(resource, params)
    if resource.encrypted_password.blank? # || params[:password].blank?
      resource.email = params[:email] if params[:email]
      if !params[:password].blank? && params[:password] == params[:password_confirmation]
        logger.info "Updating password"
        resource.password = params[:password]
        resource.save
      end
      if resource.valid?
        resource.update_without_password(params)
      end
    else
      resource.update_with_password(params)
    end
  end
  
    private

  def registration_params
    params.require(:user).permit(:email,:name, :title_id, :first_name, :last_name, 
      :province_id, :password, :password_confirmation)
  end
  
end