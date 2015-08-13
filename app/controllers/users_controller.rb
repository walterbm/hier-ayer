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
    @geojson = maps.collect do |map|
      map.moments.collect do |moment|
        moment.geojson
      end
    end.flatten

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
    current_user.unfriend(params[:friend_id])
    @friend_id = params[:friend_id]
    respond_to do |format|
      format.html { redirect_to user_path(current_user) }

      format.js { }
    end
  end
end