class MomentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    map = current_user.maps.find(map_params)
    @moment = map.moments.build(moment_params)
    @moment.build_geojson
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
    moment.build_geojson
    
    track_activity(moment)

    respond_to do |format|
      format.html { redirect_to map_path(moment.map) }
      format.js { }
    end
  end

  def destroy
    @moment = Moment.find(params[:id])
    map = @moment.map
    @moment.delete
    respond_to do |format|
      format.html { redirect_to map_path(map) }
      format.js { }
    end
  end

  def instagram_photo
    moment = Moment.find(params[:id])
    @photo = InstagramWrapper.new(current_user).recent_pic
    add_photo = moment.image_from_url(@photo)
    add_photo.save

    redirect_to map_path(moment.map.id)
  end

  private

    def map_params
      params.require(:moment).permit(:map_id)[:map_id]
    end

    def moment_params
      params.require(:moment).permit(:memo, :latitude, :longitude, :image, :delete_image)
    end
end
