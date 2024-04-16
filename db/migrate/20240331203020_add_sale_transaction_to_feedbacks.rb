class AddSaleTransactionToFeedbacks < ActiveRecord::Migration[7.1]
  def change
    add_reference :feedbacks, :sale_transaction, null: false, foreign_key: true
  end
end
