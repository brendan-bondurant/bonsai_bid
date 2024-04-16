require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:items).with_foreign_key('seller_id') }
    it { should have_many(:bids).with_foreign_key('bidder_id') }
    it { should have_many(:feedbacks).with_foreign_key('from_user_id') }
    it { should have_many(:received_feedbacks).class_name('Feedback').with_foreign_key('to_user_id') }
    it { should have_many(:purchases) }
    it { should have_many(:sales) }
  end

  describe 'validations' do
    it 'validates presence of email' do
      user = User.new(email: nil)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'validates uniqueness of email' do
      existing_user = User.create!(
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123',
        street: '123 Main St',
        city: 'Anytown',
        state: 'Anystate',
        zip: '12345'
      )
      user = User.new(email: existing_user.email)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'validates format of email' do
      valid_email_user = User.new(        
      email: 'test@example.com',
      password: 'password123',
      password_confirmation: 'password123',
      street: '123 Main St',
      city: 'Anytown',
      state: 'Anystate',
      zip: '12345'
    )
      expect(valid_email_user).to be_valid

      invalid_email_user = User.new(email: 'invalid_email', password: 'password123')
      expect(invalid_email_user).to be_invalid
      expect(invalid_email_user.errors[:email]).to include("is invalid")
    end

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

    describe 'validations' do
      it { should validate_presence_of(:street) }
      it { should validate_presence_of(:city) }
      it { should validate_presence_of(:state) }
      it { should validate_presence_of(:zip) }

    end


  end
  it 'lets you view watchlist_items' do
    user = FactoryBot.create(:user)    
    other_user = FactoryBot.create(:user)  
    listed_item = create(:item, seller: user)
    other_item = create(:item, seller: other_user)
    Watchlist.create!(user: user, item: other_item)
    expect(user.watchlist_items.count).to eq(1)
    expect(user.watchlist_items.class).to eq(Array)
    expect(user.watchlist_items.first).to eq(other_item)
  end

end
