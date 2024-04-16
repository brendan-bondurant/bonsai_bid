class UpdateWatchlistAssociation < ActiveRecord::Migration[7.1]
  def change
    remove_reference :watchlists, :user, index: true, foreign_key: true
    add_reference :watchlists, :user_profile, null: false, index: true, foreign_key: true
  end
end
