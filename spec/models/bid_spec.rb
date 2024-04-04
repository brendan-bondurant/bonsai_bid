RSpec.describe Bid, type: :model do
  describe 'associations' do
    it { should belong_to(:auction) }
    it { should belong_to(:bidder).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:bid_amount) }
    it { should validate_numericality_of(:bid_amount).is_greater_than(0) }
    it { should validate_presence_of(:bid_time) }
  end

  # Custom validation test
  it 'should validate bid time within auction start and end times' do
    seller = create(:user)
    item = create(:item, seller: seller)
    auction = create(:auction, item: item, seller: seller)
    bidder = create(:user)

    bid = build(:bid, auction: auction, bidder: bidder, bid_time: auction.start_date - 1.hour)
    expect(bid).not_to be_valid

    bid.bid_time = auction.end_date + 1.hour
    expect(bid).not_to be_valid

    bid.bid_time = auction.start_date + 1.hour
    expect(bid).to be_valid
  end
end
