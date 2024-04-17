require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:items).with_foreign_key('seller_id') }
    it { should have_many(:bids).with_foreign_key('bidder_id') }
    it { should have_many(:feedbacks).with_foreign_key('from_user_id') }
    it { should have_many(:received_feedbacks).class_name('Feedback').with_foreign_key('to_user_id') }
    it { should have_many(:purchases).class_name('SaleTransaction').with_foreign_key('buyer_id') }
    it { should have_many(:sales).class_name('SaleTransaction').with_foreign_key('seller_id') }
    it { should have_one(:user_profile).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should allow_value('12345').for(:zip) }
    it { should_not allow_value('abcde').for(:zip).with_message('invalid zip code') }
  end

  describe '#name' do
    it 'returns the name from the associated user_profile' do
      user = FactoryBot.create(:user)
      user_profile = FactoryBot.create(:user_profile, user: user, name: 'John Doe')
      expect(user.name).to eq('John Doe')
    end
  end

  describe '#watchlist_items' do
    it 'returns an array of items on the watchlist' do
      user = FactoryBot.create(:user)    
      other_user = FactoryBot.create(:user)  
      listed_item = FactoryBot.create(:item, seller: user)
      other_item = FactoryBot.create(:item, seller: other_user)
      FactoryBot.create(:watchlist, user: user, item: other_item)
      expect(user.watchlist_items.count).to eq(1)
      expect(user.watchlist_items.class).to eq(Array)
      expect(user.watchlist_items.first).to eq(other_item)
    end
  end
end
