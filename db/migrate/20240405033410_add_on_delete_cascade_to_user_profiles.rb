class AddOnDeleteCascadeToUserProfiles < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :user_profiles, :users

    add_foreign_key :user_profiles, :users, on_delete: :cascade
  end
end
