class MoveWatchlistsToAuctions < ActiveRecord::Migration[7.1]
  def change
    remove_reference :watchlists, :item, index: true, foreign_key: true
    add_reference :watchlists, :auction, index: true, foreign_key: true
  end
end
