class RemoveDateToPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :date, :string
  end
end
