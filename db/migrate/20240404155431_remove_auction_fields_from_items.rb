class RemoveAuctionFieldsFromItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :items, :starting_price, :float
    remove_column :items, :current_price, :float
    remove_column :items, :buy_it_now_price, :float
    remove_column :items, :start_date, :datetime
    remove_column :items, :end_date, :datetime
    remove_column :items, :bid_increment, :float
  end
end
