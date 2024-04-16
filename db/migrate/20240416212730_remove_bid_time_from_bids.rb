class RemoveBidTimeFromBids < ActiveRecord::Migration[7.1]
  def change
    remove_column :bids, :bid_time, :datetime
  end
end
