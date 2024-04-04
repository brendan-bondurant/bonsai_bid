class Item < ApplicationRecord
  enum status: { listed: 0, active: 1, sold: 2, ended: 3 }

  belongs_to :seller, class_name: 'User'
  belongs_to :category
  has_many :feedbacks
  has_many :watchlists
  has_one :sale_transaction
  has_many :inquiries


  validates :name, presence: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: %w(listed active sold ended) }
  validates :status, presence: true
  
end
