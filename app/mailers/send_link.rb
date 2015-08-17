class SendLink < ApplicationMailer
  default from: "moments.application@gmail.com"
  
  def share_link(map, friend_email)
    @map = map
    @friend_email = friend_email
    mail to: @friend_email, subject: "#{@map.user.name.capitalize} has shared a moment with you!"
  end
end
