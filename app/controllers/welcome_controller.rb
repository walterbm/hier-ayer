class WelcomeController < ApplicationController

  def index
    
  end
  
  def geojson
    @geojson = Array.new
    users = User.all
    users.each do |user|
      user.maps.each do |map|
        map.moments.each do |moment|
          @geojson << {
            type: 'Feature',
            geometry: {
              type: 'Point',
              coordinates: [moment.longitude, moment.latitude]
            }
          }
        end
      end
    end

     render json: @geojson
  end

  def theme_test
  end
  
end
