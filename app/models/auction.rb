class Auction < ApplicationRecord
  belongs_to :item
  belongs_to :seller, class_name: 'User'
end
