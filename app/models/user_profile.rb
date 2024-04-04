class UserProfile < ApplicationRecord
  belongs_to :user
  has_many :watchlists, dependent: :destroy

  
  validates :address, presence: true
  validates :name, presence: true
  validates :phone, format: { with: /\A\d{10}\z/, message: "must be a 10 digit number" }, presence: true
end
