class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :maps, -> { order(:created_at) } 
  has_many :moments, through: :maps
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

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

  def add_friend(friend_name)
    if friend_name == self.name
      "Sorry, narcissist, you can't follow yourself"
    elsif self.friends.include?(User.find_by(name: friend_name))
      "Already following #{friend_name}"
    elsif user_exists?(friend_name)
      self.friends << User.find_by(name: friend_name)
      "Now following #{friend_name}!"
    else
      "Sorry, no such user"
    end
  end

  def unfriend(friend_id)
    friendships = self.friendships.find_by(friend_id: friend_id)
    friendships.destroy
    self.reload
  end

  def followers
    self.inverse_friends
  end
end
