class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
