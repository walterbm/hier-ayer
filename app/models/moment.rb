class Moment < ActiveRecord::Base
  belongs_to :map
  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  attr_accessor :delete_image
  before_validation { image.clear if delete_image == '1'}

  # def get_instagram_photos
  #   @photos = Instagram.new
  # end
  
  #Geocoder
  reverse_geocoded_by :latitude, :longitude

  def build_geojson
    self.update(geojson: {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [self.longitude, self.latitude]
        },
        properties: {
          'description' => self.memo,
          'image' => self.image.exists? ? self.image.url: nil,
          'marker-color' => '#15b3d9',
          'marker-symbol' => 'star-stroked',
          'marker-size' => 'medium'
        }
      })
  end

end
