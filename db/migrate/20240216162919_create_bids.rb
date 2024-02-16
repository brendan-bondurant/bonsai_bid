class CreateBids < ActiveRecord::Migration[7.1]
  def change
    create_table :bids do |t|
      t.references :item, null: false, foreign_key: true
      t.references :bidder, null: false, foreign_key: { to_table: :users }
      t.float :bid_amount
      t.datetime :bid_time

      t.timestamps
    end
  end
end
