class Map < ActiveRecord::Base
  belongs_to :user
  has_many :moments, -> { order(:created_at) } 
end
