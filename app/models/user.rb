require 'bcrypt'

class User < ActiveRecord::Base
  has_many :maps
  has_many :moments, through: :maps
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  include BCrypt


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def new_map(map_hash)
    self.maps.build(map_hash)
  end

  def delete_map(map_id)
    map = self.maps.find_by(map_id)
    map.destroy
  end

  def add_friend(friend_id)
    self.friends.build(friend_id)
  end

  def unfriend(friend_id)
    friend = self.friends.find_by(friend_id)
    friend.destroy
  end

end
