require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe 'associations' do
    it { should belong_to(:item) }
    it { should belong_to(:bidder).class_name('User') }
  end
end