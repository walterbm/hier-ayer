class MapsController < ApplicationController
  def new
    @map = Map.new
  end
  
  def create
    map = current_user.new_map(map_params)
    map.save
    redirect_to map_path(map, params)
  end

  def show
    @map = Map.find(params[:id])
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
  
  def create_json
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
            name: moment.memo,
            :'marker-color' => '#00607d',
            :'marker-symbol' => 'circle',
            :'marker-size' => 'medium'
          }
        }
      end

     render json: 'yippidy fuckin doo dah'  # respond with the created JSON object
  end 
  
  private
    def map_params
      params.require(:map).permit(:name, moment: [:memo, :latitude, :longitude, :image])
    end
end
