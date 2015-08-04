class Moment < ActiveRecord::Base
  belongs_to :map
  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  attr_accessor :delete_image
  before_validation { image.clear if delete_image == '1'}

end
