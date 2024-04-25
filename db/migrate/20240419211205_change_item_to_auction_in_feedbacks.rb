class ChangeItemToAuctionInFeedbacks < ActiveRecord::Migration[7.1]
  def change
    remove_reference :feedbacks, :item, index: true, foreign_key: true
    add_reference :feedbacks, :auction, null: false, index: true, foreign_key: true
  end
end
