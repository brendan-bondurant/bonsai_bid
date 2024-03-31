class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.bigint :buyer_id
      t.bigint :seller_id
      t.bigint :item_id
      t.decimal :final_price
      t.datetime :transaction_time

      t.timestamps
    end
    add_index :transactions, :buyer_id
    add_index :transactions, :seller_id
    add_index :transactions, :item_id
    add_foreign_key :transactions, :users, column: :buyer_id
    add_foreign_key :transactions, :users, column: :seller_id
    add_foreign_key :transactions, :items
  end
end
