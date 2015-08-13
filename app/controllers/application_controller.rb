require 'pusher'

Pusher.app_id = ENV["pusher_app_id"]
Pusher.key = ENV["pusher_key"]
Pusher.secret = ENV["pusher_secret"]  

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def track_activity(trackable_object)
    activity = current_user.activities.create(action: params[:action], trackable: trackable_object)
    Pusher['feed_channel'].trigger('feed_event', {
      activity_id: activity.id
    })
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :avatar
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :avatar
  end

end