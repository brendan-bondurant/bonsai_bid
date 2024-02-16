class Bid < ApplicationRecord
  belongs_to :item
  belongs_to :bidder, class_name: 'User'

  validates :bid_amount, presence: true, numericality: { greater_than: 0 }
  validates :bid_time, presence: true
end
