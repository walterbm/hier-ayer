class ChangeColumnNameOfPassword < ActiveRecord::Migration
  def change
    rename_column :users, :password_hash, :password_digest
  end
end
