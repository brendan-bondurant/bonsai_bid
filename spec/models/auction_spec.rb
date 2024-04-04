require 'rails_helper'

RSpec.describe Auction, type: :model do
  describe 'associations' do
    it { should belong_to(:item) }
    it { should belong_to(:seller).class_name('User') }
    it { should have_many(:bids)}
  end

  describe 'validations' do
    it { should validate_presence_of(:item_id) }
    it { should validate_presence_of(:seller_id) }
    it { should validate_presence_of(:start_date) }
    # it { should validate_presence_of(:starting_price) }
    it { should validate_numericality_of(:starting_price) }
    it { should validate_presence_of(:end_date) }
    # it { should validate_presence_of(:bid_increment) }
    it { should validate_numericality_of(:bid_increment) }

  end
end
