class SendLink < ApplicationMailer
  default from: "moments.application@gmail.com"
  
  def share_link(user, friend_email)
    @user = user
    @friend_email = friend_email
    mail to: @friend_email, subject: 'A moment has been shared with you!'
  end
end
