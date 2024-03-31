class RenameTransactionsToSaleTransactions < ActiveRecord::Migration[7.1]
  def change
    rename_table :transactions, :sale_transactions
  end
end
