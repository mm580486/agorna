class UserMailer < ApplicationMailer
  default from: 'notifications@pinsood.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'به پین سود خوش آمدید')
  end
end
