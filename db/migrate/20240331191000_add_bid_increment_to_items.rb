class AddBidIncrementToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :bid_increment, :float
  end
end
