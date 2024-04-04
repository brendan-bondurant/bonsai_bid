class Watchlist < ApplicationRecord
  belongs_to :user_profile
  belongs_to :item
  



  # def seller_name
  #   user = User.find(self.user_id)
  #   user.name
  # end

  # def item_name
  #   item = Item.find(self.item_id)
  #   item.name
  # end



end
