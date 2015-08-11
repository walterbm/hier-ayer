class ActivitiesController < ApplicationController

  def index
    @activities = Activity.feed
  end
  
end
