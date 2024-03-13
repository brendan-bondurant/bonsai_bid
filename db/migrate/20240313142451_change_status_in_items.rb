class ChangeStatusInItems < ActiveRecord::Migration[7.1]
  def up
    # Change the column type from string to integer
    change_column :items, :status, :integer, using: 'status::integer', default: 0, null: false

    # Optional: If you have existing data, you may need to define a mapping from string values to integers.
    # For example:
    # Item.where(status: 'active').update_all(status: 0)
    # Item.where(status: 'archived').update_all(status: 1)
  end

  def down
    # Revert the column type from integer to string
    # It's important to define the down method to ensure your migrations are reversible.
    change_column :items, :status, :string, using: 'status::text', default: 'listed', null: false
  end
end
