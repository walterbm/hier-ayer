class AddPublicBooleanToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :public, :boolean, default: false
  end
end
