class RemoveStatusFromItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :items, :status, :integer
  end
end
