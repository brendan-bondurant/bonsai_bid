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
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }

    it { should validate_presence_of(:name) }

    it { should allow_value('1234567890').for(:phone) }
    it { should_not allow_value('123').for(:phone) }
    it { should_not allow_value('abcdefghij').for(:phone) }
    it { should_not allow_value('12345678901').for(:phone) }
  end
end
