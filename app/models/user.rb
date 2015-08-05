class User < ActiveRecord::Base
  has_many :maps
  has_many :moments, through: :maps
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  
  has_secure_password

  def new_map(map_hash)
    self.maps.build(map_hash)
  end

  def delete_map(map_id)
    map = self.maps.find(map_id)
    map.destroy
  end
  def user_exists?(user)
    !!User.find_by(name: user)
  end
  def add_friend(friend)
      friend = User.find_by(name: friend)
      self.friends << friend
  end

  def unfriend(friend)
    friendships = self.friendships.find_by(friend_id: friend.id)
    friendships.destroy
    self.reload
  end

  def followers
    self.inverse_friends
  end

end
