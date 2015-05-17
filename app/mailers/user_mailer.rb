class UserMailer < ActionMailer::Base
  
  default from: 'lukebrown4290@hotmail.com'
  
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end
