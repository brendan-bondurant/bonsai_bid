class User < ApplicationRecord
  has_many :items, foreign_key: 'seller_id'
  has_many :bids, foreign_key: 'bidder_id'
  has_many :feedbacks, foreign_key: 'from_user_id'
  has_many :received_feedbacks, class_name: 'Feedback', foreign_key: 'to_user_id'
  has_many :watchlists
end
