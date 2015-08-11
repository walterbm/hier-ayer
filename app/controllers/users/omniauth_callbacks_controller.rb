class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def instagram
    @auth_params = request.env["omniauth.auth"]
    @auth = call(request.env['omniauth.auth'], current_user)
    @user = @auth.user
    @user.save
    binding.pry
    if user_signed_in?    
      flash[:notice] = 'You have added a new authentication!'
      redirect_to :root
    else
      sign_in_and_redirect(:user, @user)
    end
  end  


  def call(auth_hash, current_user = nil)
    auth = Authentication.find_or_initialize_by(uid: auth_hash[:uid], provider: auth_hash[:provider])
    if !current_user || !auth.user 
      # You need to adapt this to the provider and your user model
      user = User.new(
        name: auth_hash[:info][:name],
        password: auth_hash[:info][:name],
        password_confirmation: auth_hash[:info][:name],
        email: auth_hash[:info][:name]
      )
    end

    auth.update(user: current_user ? current_user : user)
    auth
  end
     # OmniAuth creates a normalized 
     # hash of the credentials and info supplied by the provider.
     #@auth_params = request.env["omniauth.auth"]
     # @todo check if authentication exists
     # @todo find user for authentication
     # @todo create account for new users
     # @todo sign user in
 




    # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.from_omniauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, :kind => "Instagram") if is_navigational_format?
  #   else
  #     session["devise.instagram_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end
end