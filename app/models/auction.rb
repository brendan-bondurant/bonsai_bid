class Auction < ApplicationRecord
  belongs_to :item
  belongs_to :seller, class_name: 'User'
  has_many :bids

  validates :item_id, :seller_id, :start_date, :end_date, presence: true
  validates :starting_price, :bid_increment, numericality: { greater_than_or_equal_to: 0 }
  validate :end_date_after_start_date

  def current_highest_bid
    highest_bid = bids.order(bid_amount: :desc).first
    highest_bid ? highest_bid.bid_amount : "no bids"
  end

  def bidding_open?
    now = Time.now
    start_date <= now && now <= end_date
  end

private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    errors.add(:end_date, "must be after the start date") if end_date < start_date
  end
end
