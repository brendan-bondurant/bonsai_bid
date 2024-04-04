class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # has_secure_password
  has_one :user_profile, dependent: :destroy
  has_many :items, foreign_key: 'seller_id'
  has_many :bids, foreign_key: 'bidder_id'
  has_many :feedbacks, foreign_key: 'from_user_id'
  has_many :received_feedbacks, class_name: 'Feedback', foreign_key: 'to_user_id'

  has_many :purchases, class_name: 'SaleTransaction', foreign_key: 'buyer_id'
  has_many :sales, class_name: 'SaleTransaction', foreign_key: 'seller_id'
  has_many :inquiries, foreign_key: :commenter_id
  has_many :received_inquiries, class_name: 'Inquiry', foreign_key: :seller_id
  has_many :auctions, foreign_key: :seller_id

  # validates :address, presence: true
  # validates :name, presence: true
  # validates :phone, format: { with: /\A\d{10}\z/, message: "must be a 10 digit number" }, presence: true

  def watchlist_items
    favorites = []
    self.watchlists.each do |favs|
      item = Item.find(favs.item_id)
      favorites << item
    end
    favorites
  end
end
