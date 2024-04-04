class CreateUserProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :user_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :address
      t.string :phone

      t.timestamps
    end
  end
end
