require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it { should belong_to(:seller).class_name('User') }
    it { should belong_to(:category) }
    it { should have_many(:bids) }
    it { should have_many(:feedbacks) }
    it { should have_many(:watchlists) }
  end
end