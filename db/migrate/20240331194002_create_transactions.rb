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
  end
end
