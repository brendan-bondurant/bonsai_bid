class UpdateWatchlistToBelongToUser < ActiveRecord::Migration[7.1]
  def change
    remove_reference :watchlists, :user_profile, index: true, foreign_key: true
    add_reference :watchlists, :user, null: false, index: true, foreign_key: true
  end
end
