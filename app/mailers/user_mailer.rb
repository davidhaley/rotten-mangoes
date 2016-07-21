class UserMailer < ApplicationMailer
  default from: 'notifications@rottenmangoes.com'
 
  def notify_user_delete(user)
    mail(to: user.email, subject: 'Account Deleted')
  end
end
