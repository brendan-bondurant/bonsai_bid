class Bid < ApplicationRecord
  belongs_to :item
  belongs_to :bidder
end
