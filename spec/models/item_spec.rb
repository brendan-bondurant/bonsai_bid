require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it { should belong_to(:seller).class_name('User') }
    it { should belong_to(:category) }
    it { should have_many(:bids) }
    it { should have_many(:feedbacks) }
    it { should have_many(:watchlists) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:starting_price).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:current_price).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:buy_it_now_price).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:bid_increment) }
  end

  describe 'callbacks' do
    describe '#set_default_status' do
      context 'when creating a new record' do
        let(:item) { Item.new }

        it 'sets the default status to "listed"' do
          item.valid?

          expect(item.status).to eq('listed')
        end
      end
      context 'when status is already set' do
        let(:item) { Item.new(status: 'sold') }

        it 'does not override the existing status' do
          item.valid?
          expect(item.status).to eq('sold')
        end
      end
    end
  end
end