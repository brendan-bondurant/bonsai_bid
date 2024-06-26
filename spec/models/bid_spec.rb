RSpec.describe Bid, type: :model do
  describe 'associations' do
    it { should belong_to(:auction) }
    it { should belong_to(:bidder).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:bid_amount) }
    it { should validate_numericality_of(:bid_amount).is_greater_than(0) }
  end
end
