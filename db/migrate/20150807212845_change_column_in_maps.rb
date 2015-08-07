class ChangeColumnInMaps < ActiveRecord::Migration
  def change
    rename_column :maps, :public, :publicly_available
  end
end
