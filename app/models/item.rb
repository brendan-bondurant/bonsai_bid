class Item < ApplicationRecord
  enum status: { listed: 0, active: 1, sold: 2, ended: 3 }

  belongs_to :seller, class_name: 'User'
  belongs_to :category
  has_many :bids
  has_many :feedbacks
  has_many :watchlists
  has_one :sale_transaction

  validates :name, presence: true
  validates :description, presence: true
  validates :starting_price, numericality: { greater_than_or_equal_to: 0 }
  validates :current_price, numericality: { greater_than_or_equal_to: 0 }
  validates :buy_it_now_price, numericality: { greater_than_or_equal_to: 0 }
  validates :start_date, presence: true
  validates :bid_increment, presence: true
  validates :end_date, presence: true
  validates :status, presence: true, inclusion: { in: %w(listed active sold ended) }
  validates :status, presence: true


  # after_initialize :set_default_status, if: :new_record?
  
  private

  def set_default_status
    self.status ||= :listed
  end
end
