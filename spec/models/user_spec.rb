require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:items).with_foreign_key('seller_id') }
    it { should have_many(:bids).with_foreign_key('bidder_id') }
    it { should have_many(:feedbacks).with_foreign_key('from_user_id') }
    it { should have_many(:received_feedbacks).class_name('Feedback').with_foreign_key('to_user_id') }
    it { should have_many(:watchlists) }
  end

  describe 'validations' do
    it 'validates presence of email' do
      user = User.new(email: nil)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'validates uniqueness of email' do
      existing_user = User.create!(id: 1, name: 'test', email: 'test@example.com', password: 'password123', address: '543 Main', phone: 1231231234, password_confirmation: 'password123')
      user = User.new(email: existing_user.email)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'validates format of email' do
      valid_email_user = User.new(email: 'test@example.com', password: 'password123', name: 'Test User', address: '543 Main', phone: 1231231234)
      expect(valid_email_user).to be_valid

      invalid_email_user = User.new(email: 'invalid_email', password: 'password123', name: 'Test User', address: '543 Main', phone: 1231231234)
      expect(invalid_email_user).to be_invalid
      expect(invalid_email_user.errors[:email]).to include("is invalid")
    end

    # Password
    it 'validates presence of password' do
      user = User.new(password: nil)
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'validates length of password' do
      short_password = 'short'
      user = User.new(password: short_password)
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    # Name
    it { should validate_presence_of(:name) }

    # Phone
    it { should allow_value('1234567890').for(:phone) }
    it { should_not allow_value('123').for(:phone) }
    it { should_not allow_value('abcdefghij').for(:phone) }
    it { should_not allow_value('12345678901').for(:phone) }
  end
  it 'lets you view watchlist_items' do
    user = User.create!(id: 1000, name: 'test1', email: 'test@example.com', password: 'password123', address: '543 Main', phone: 1231231234, password_confirmation: 'password123')    
    other_user = User.create!(id: 1001, name: 'test1001', email: 'test123@example.com', password: 'password123', address: '321 Main', phone: 1234561234, password_confirmation: 'password123')   
    listed_item = create(:item, seller: user)
    other_item = create(:item, seller: other_user)
    Watchlist.create!(user_id: user.id, item_id: other_item.id)
    expect(user.watchlist_items.count).to eq(1)
    expect(user.watchlist_items.class).to eq(Array)
    expect(user.watchlist_items.first).to eq(other_item)
  end

end
