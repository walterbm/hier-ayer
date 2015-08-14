require 'open-uri'

class Moment < ActiveRecord::Base
  belongs_to :map
  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  attr_accessor :delete_image, :address
  before_validation { image.clear if delete_image == '1'}

  def image_from_url(url)
    self.image = URI.parse(url)
    self.save
    self.image
  end
  
  #Geocoder
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude

  def build_geojson
    self.save
    self.update(geojson: {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [self.longitude, self.latitude]
        },
        properties: {
          'title' => self.map.name,
          'description' => self.memo,
          'image' => (self.image.exists? ? self.image.url : nil),
          'marker-color' => '#15b3d9',
          'marker-symbol' => 'star-stroked',
          'marker-size' => 'medium'
        }
      })
  end

end
