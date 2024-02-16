class User < ApplicationRecord
  has_secure_password

  has_many :items, foreign_key: 'seller_id'
  has_many :bids, foreign_key: 'bidder_id'
  has_many :feedbacks, foreign_key: 'from_user_id'
  has_many :received_feedbacks, class_name: 'Feedback', foreign_key: 'to_user_id'
  has_many :watchlists
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  validates :name, presence: true
  validates :phone, format: { with: /\A\d{10}\z/, message: "must be a 10 digit number" }, allow_blank: true
end
