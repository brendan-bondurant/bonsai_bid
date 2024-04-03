class CreateInquiries < ActiveRecord::Migration[7.1]
  def change
    create_table :inquiries do |t|
      t.bigint :commenter_id
      t.bigint :seller_id
      t.bigint :item_id
      t.text :comment
      t.integer :parent_id

      t.timestamps
    end
    add_index :inquiries, :parent_id
  end
end
