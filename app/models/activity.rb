class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  def self.feed
    includes(:trackable).order(created_at: :desc)
  end

end
