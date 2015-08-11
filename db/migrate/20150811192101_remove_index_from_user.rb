class RemoveIndexFromUser < ActiveRecord::Migration
  def change
    remove_index(:users, column: :provider)
    remove_index(:users, column: :uid)
  end
end
