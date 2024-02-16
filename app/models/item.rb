class Item < ApplicationRecord
  belongs_to :seller, class_name: 'User'
  belongs_to :category
  has_many :bids
  has_many :feedbacks
  has_many :watchlists
end
