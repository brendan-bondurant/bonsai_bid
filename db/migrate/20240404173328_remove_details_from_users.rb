class RemoveDetailsFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :name, :string
    remove_column :users, :address, :text
    remove_column :users, :phone, :string
  end
end
