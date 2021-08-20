class ChangePasswordColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :password_digest, :string
    add_column :users, :password_hash, :string
  end
end
