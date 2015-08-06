class UsersController < ApplicationController
  skip_before_action :login_required
 
 def new
   @user = User.new
 end

 def create
   @user = User.new(user_params)
   if @user.save
     redirect_to login_path, :notice => "Now please login"
   else
     render :new
   end
 end

 def show
  @user = User.find_by_id(params[:id])
 end 

 def friends
  @user = User.find(params[:user_id])
 end

 def add_friend
  user = User.find_by(params[:user_id])
  if user.user_exists?(params[:friends])
    user.add_friend(params[:friends])
  else
    flash[:notice] = "no such user"
  end
  redirect_to user_friends_path(user)
 end

 def remove_friend
  user = User.find(params[:user_id])
  user.unfriend(params[:friend_id])

  redirect_to user_friends_path(user)
 end

 private
   def user_params
     params.require(:user).permit(:name, :email, :password, :password_confirmation, :friends)
   end
end