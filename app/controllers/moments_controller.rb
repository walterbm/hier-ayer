class MomentsController < ApplicationController

  def edit
    @moment = Moment.find(params[:id])
  end

  def update
    moment = Moment.find(params[:id])
    moment.update(moment_params)

    redirect_to map_path(moment.map)
  end

  def destroy
    moment = Moment.find(params[:id])
    map = moment.map
    moment.delete

    redirect_to map_path(map)
  end

  private

    def moment_params
      params.require(:moment).permit(:memo, :latitude, :longitude, :image, :delete_image)
    end
end
