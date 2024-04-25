class AddStatusToAuctions < ActiveRecord::Migration[7.1]
  def change
    add_column :auctions, :status, :integer, default: 0
  end
end
