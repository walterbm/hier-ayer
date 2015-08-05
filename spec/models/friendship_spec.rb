require 'rails_helper'

RSpec.describe Friendship, type: :model do
   describe 'user has many friends' do

    let(:user_one) { 
                  User.create(name: "Jeff",
                    email: "jeff@jeff.com",
                    password: "12345") 
                }
     let(:user_two) { 
                  User.create(name: "Avi",
                    email: "avi@avi.com",
                    password: "12345") 
                }

    it 'has no friends' do
      expect(user_one.friends).not_to include(user_two)
    end

    it 'friend belong to user' do 
      user_one.friends << user_two
      expect(user_one.friends).to include(user_two)
    end

    it 'can add friends using the add_friend method' do
      user_one.add_friend(user_two)
      expect(user_one.friends).to include(user_two)
    end

    it 'can un-friend using the unfriend method' do
      user_one.add_friend(user_two)
      user_one.unfriend(user_two)
      user_one.reload 
      expect(user_one.friends).not_to include(user_two)
    end

    it 'inverse friend has a follower' do
      user_one.friends << user_two
      expect(user_two.followers).to include(user_one)
    end

  end
end
