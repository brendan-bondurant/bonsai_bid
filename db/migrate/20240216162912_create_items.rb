class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :seller, null: false, foreign_key: { to_table: :users }
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.text :images
      t.float :starting_price
      t.float :current_price
      t.float :buy_it_now_price
      t.datetime :start_date
      t.datetime :end_date
      t.string :status

      t.timestamps
    end
  end
end
