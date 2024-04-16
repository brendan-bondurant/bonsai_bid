class RemoveAddressFromUserProfiles < ActiveRecord::Migration[7.1]
  def change
    remove_column :user_profiles, :address, :string
  end
end
