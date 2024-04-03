class RemoveTransactionTimeFromSaleTransactions < ActiveRecord::Migration[7.1]
  def change
    remove_column :sale_transactions, :transaction_time, :datetime
  end
end
