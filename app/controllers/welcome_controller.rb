class WelcomeController < ApplicationController

  def index 
  end
  
  def geojson
    @geojson = User.all.collect do |user|
      user.maps.collect do |map|
        map.moments.collect do |moment|
          moment.geojson.except!("properties")
        end
      end
    end.flatten(2)

    render json: @geojson
  end
  
end
