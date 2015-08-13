class ActivitiesController < ApplicationController  

  def item
    render "_activity", :layout => false, locals: {activity: Activity.find(params[:id])}
  end

end
