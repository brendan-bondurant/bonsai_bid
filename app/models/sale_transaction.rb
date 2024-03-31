class SaleTransaction < ApplicationRecord
  belongs_to :buyer, class_name: 'User'
  belongs_to :seller, class_name: 'User'
  belongs_to :item
  has_many :feedbacks

  validates :buyer_id, presence: true
  validates :seller_id, presence: true
  validates :item_id, presence: true
  validates :final_price, presence: true

end
