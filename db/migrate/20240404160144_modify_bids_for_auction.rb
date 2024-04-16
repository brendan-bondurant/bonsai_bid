class ModifyBidsForAuction < ActiveRecord::Migration[7.1]
  def change
    remove_reference :bids, :item, index: true, foreign_key: true
    add_reference :bids, :auction, null: false, index: true, foreign_key: true
  end
end
