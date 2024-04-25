class MoveSaleTransactionsToAuctions < ActiveRecord::Migration[7.1]
  def change
    remove_reference :sale_transactions, :item, index: true, foreign_key: true
    add_reference :sale_transactions, :auction, index: true, foreign_key: true
  end
end
