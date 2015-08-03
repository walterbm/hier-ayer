class MapsController < ApplicationController
  def new
    @map = Map.new
  end
  
  def create
    @map = Map.create(map_params)
    @map.user = current_user
    @moment = Moment.create(moment_params)
    @map.moments << @moment
    @map.save
    redirect_to map_path(@map)
  end
  
  def destroy
    
  end
  
  def show
    @map = Map.find(params[:id])
  end
  
  private
    def map_params
      params.require(:map).permit(:name)
    end
  
    def moment_params
      params.require(:map).permit(moments: [:memo, :latitude, :longitude])[:moments]
    end
end
