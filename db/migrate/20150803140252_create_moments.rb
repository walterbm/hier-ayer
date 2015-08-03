class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.integer :map_id
      t.text :memo
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
