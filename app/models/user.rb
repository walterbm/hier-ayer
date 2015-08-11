class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:instagram]

  has_many :maps, -> { order(:created_at) } 
  has_many :moments, through: :maps
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :authentications
  has_many :activities


  has_attached_file :avatar, 
                    :styles => { :thumb => "100x100#" },
                    :default_url => "missing_avatar.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      binding.pry
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      binding.pry
      user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.instagram_data"] && session["devise.instagram_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def new_map(map_params)
    self.maps.build(map_params)
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
