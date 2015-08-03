class SessionsController < ApplicationController
  skip_before_action :login_required, :only => [:new, :create]
  
  def new
    
  end
  
  def create
   @user = User.find_by(:email => params[:email])

   if @user && @user.authenticate(params[:password])
     login(@user)
     flash[:notice] = "Logged in successfully!!!"
     redirect_to root_path
   else
     flash.now[:notice] = "Can't find that user."
     render :new
   end
 end

 def destroy
   reset_session
   redirect_to root_path
 end

 private
   def login(user)
     session[:user_id] = user.id
   end
end
