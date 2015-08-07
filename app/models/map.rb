class Map < ActiveRecord::Base
  belongs_to :user
  has_many :moments, -> { order(:created_at) } 

  def update_all(map_params)
    if map_params[:name]
      self.update(map_params)
    elsif map_params[:moment]
      self.moments.build(map_params[:moment])
      self.save
    end
  end
end
