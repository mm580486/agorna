class RegistrationsController < Devise::RegistrationsController
 
 
 
   def create
super
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
    params.require(:user).permit(:email,:name,:phone, :title_id, :first_name, :last_name, 
      :province_id, :password, :password_confirmation)
  end
  
end