class UsersController < ApplicationController
  before_filter :authenticate_user!
 
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end 

  def geojson
    @maps = current_user.maps
    @geojson = Array.new
    @maps.each do |map|
      map.moments.each do |moment|
        @geojson << {
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [moment.longitude, moment.latitude]
          },
          properties: {
            'description': moment.memo,
            'image': moment.image.url,
            'marker-color': '#15b3d9',
            'marker-symbol': 'star-stroked',
            'marker-size': 'medium'
          }
        }
      end
    end

     render json: @geojson
  end
  
  def friends
    @user = User.find(params[:user_id])
  end

  def add_friend
    user = User.find(params[:user_id])
    message = user.add_friend(params[:friend_name])
    flash[:notice] = message
    
    redirect_to user_friends_path(user)
  end

  def remove_friend
    user = User.find(params[:user_id])
    user.unfriend(params[:friend_id])

    redirect_to user_friends_path(user)
  end

end