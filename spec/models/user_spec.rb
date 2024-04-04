require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:items).with_foreign_key('seller_id') }
    it { should have_many(:bids).with_foreign_key('bidder_id') }
    it { should have_many(:feedbacks).with_foreign_key('from_user_id') }
    it { should have_many(:received_feedbacks).class_name('Feedback').with_foreign_key('to_user_id') }
    # it { should have_many(:watchlists) }
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
      existing_user = User.create!(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
      user = User.new(email: existing_user.email)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'validates format of email' do
      valid_email_user = User.new(email: 'test@example.com', password: 'password123')
      expect(valid_email_user).to be_valid

      invalid_email_user = User.new(email: 'invalid_email', password: 'password123')
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


  end


end
