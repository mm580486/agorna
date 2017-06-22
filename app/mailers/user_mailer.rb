class UserMailer < ApplicationMailer
  default from: 'notifications@pinsood.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'به پین سود خوش آمدید')
  end
  
  
    def user_errors(error_title='',error_message)
    @error_title=error_title
    @error_message=error_message
    @url  = 'http://example.com/login'
    mail(to: 'mm580486@gmail.com', subject: 'خطا')
  end
  
end
