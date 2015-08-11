class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :uid
      t.string :provider
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :authentications, :users
  end
end
