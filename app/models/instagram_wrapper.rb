require 'open-uri'

class InstagramWrapper 

  attr_accessor :user_uid, :client_id, :base_uri

  def initialize(user)
    @client = Instagram.client(:client_id => ENV["INSTAGRAM_APP_ID"])
    @client_id = @client.client_id
    @user_uid = user.uid
    @base_uri = "https://api.instagram.com/v1/users"
  end

  def recent_pic
    url = "#{base_uri}/#{user_uid}/media/recent/?client_id=#{client_id}"
    path = open(url).read
    data_hash = JSON.parse(path)
    most_recent_pic = data_hash["data"][0]["images"]["standard_resolution"]["url"]
    most_recent_pic
  end
end
