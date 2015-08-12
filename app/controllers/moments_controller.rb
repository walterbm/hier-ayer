class MomentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    map = current_user.maps.find(map_params)
    @moment = map.moments.build(moment_params)
    map.save

    track_activity(@moment)
    
    respond_to do |format|
      format.html { redirect_to map_path(map) }
      format.js { }
    end
  end

  def edit
    @moment = Moment.find(params[:id])
  end

  def update
    moment = Moment.find(params[:id])
    moment.update(moment_params)
    
    track_activity(moment)

    redirect_to map_path(moment.map)
  end

  def destroy
    moment = Moment.find(params[:id])
    map = moment.map
    moment.delete

    redirect_to map_path(map)
  end

  def instagram_photos
    @photos = Instagram.new
  end

  private

    def map_params
      params.require(:moment).permit(:map_id)[:map_id]
    end

    def moment_params
      params.require(:moment).permit(:memo, :latitude, :longitude, :image, :delete_image)
    end
end
