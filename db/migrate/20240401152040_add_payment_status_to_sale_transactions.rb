class AddPaymentStatusToSaleTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :sale_transactions, :payment_status, :integer, default: 0, null: false
  end
end
