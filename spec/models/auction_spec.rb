require 'rails_helper'

RSpec.describe Auction, type: :model do
  describe 'associations' do
    it { should belong_to(:item) }
    it { should belong_to(:seller).class_name('User') }
    it { should have_many(:bids) }
  end

  describe 'validations' do
    subject { FactoryBot.create(:auction) }
    it { should validate_presence_of(:item_id) }
    it { should validate_presence_of(:seller_id) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_numericality_of(:starting_price).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:bid_increment).is_greater_than_or_equal_to(0) }

    describe 'custom validation: end_date must be after start_date' do
      let(:auction) { FactoryBot.build(:auction, start_date: Time.now, end_date: 1.day.ago) }

      it 'is invalid if end_date is before start_date' do
        expect(auction).not_to be_valid
        expect(auction.errors[:end_date]).to include('must be after the start date')
      end
    end
  end

  describe '#current_highest_bid' do
    let(:auction) { FactoryBot.create(:auction) }
    let!(:bid_one) { FactoryBot.create(:bid, auction: auction, bid_amount: 100) }
    let!(:bid_two) { FactoryBot.create(:bid, auction: auction, bid_amount: 200) }

    it 'returns the highest bid amount' do
      expect(auction.current_highest_bid).to eq(200)
    end

    context 'when there are no bids' do
      before { auction.bids.destroy_all }

      it 'returns "no bids"' do
        expect(auction.current_highest_bid).to eq("no bids")
      end
    end
  end

  describe '#bidding_open?' do
    let(:auction) { FactoryBot.create(:auction, start_date: 1.day.ago, end_date: 1.day.from_now) }

    it 'returns true when the current time is between start_date and end_date' do
      expect(auction.bidding_open?).to be true
    end

    context 'when the auction has not started yet' do
      before { auction.start_date = 1.day.from_now }

      it 'returns false' do
        expect(auction.bidding_open?).to be false
      end
    end

    context 'when the auction has already ended' do
      before { auction.end_date = 1.day.ago }

      it 'returns false' do
        expect(auction.bidding_open?).to be false
      end
    end
  end

end
