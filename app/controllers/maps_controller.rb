class MapsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @map = Map.new
  end
  
  def create
    map = current_user.new_map(map_params)
    map.save
    redirect_to map_path(map)
  end

  def show
    @map = Map.find(params[:id])
    @user = current_user
  end

  def edit
    @map = current_user.maps.find(params[:id])
  end

  def update
    map = current_user.maps.find(params[:id])
    map.update_all(map_params)
    
    redirect_to map_path(map)
  end
  
  def destroy
    current_user.delete_map(params[:id])

    redirect_to user_path(current_user)
  end
  
  def geojson
    @map = current_user.maps.find(params[:map_id])
     @geojson = Array.new
      @map.moments.each do |moment|
        @geojson << {
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [moment.longitude, moment.latitude]
          },
          properties: {
            'description': moment.memo,
            'image': moment.image.url,
            'marker-color': '#15b3d9',
            'marker-symbol': 'star-stroked',
            'marker-size': 'medium'
          }
        }
      end

     render json: @geojson
  end 
  
  private
    def map_params
      params.require(:map).permit(:name, moment: [:memo, :latitude, :longitude, :image])
    end
end
