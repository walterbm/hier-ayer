class UsersController < ApplicationController
  before_filter :authenticate_user!
 
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end 

  def geojson 
    maps = User.find(params[:user_id]).maps
    @geojson = Array.new
    maps.each do |map|
      map.moments.each do |moment|
        @geojson << {
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [moment.longitude, moment.latitude]
          },
          properties: {
            'title': map.name,
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

  def add_friend
  message = current_user.add_friend(params[:friend_name])
  flash[:notice] = message
  @friend = User.find_by(name: params[:friend_name])
  respond_to do |format|
    format.html { redirect_to user_path(@friend) }
    format.js { }
    end
  end

  def remove_friend
  @remove = current_user.unfriend(params[:friend_id])

  respond_to do |format|
    format.html { redirect_to user_path(current_user) }
    format.js { }
    end
  end

end