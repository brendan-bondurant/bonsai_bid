require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe 'associations' do
    it { should belong_to(:item) }
    it { should belong_to(:from_user).class_name('User') }
    it { should belong_to(:to_user).class_name('User') }
    it { should belong_to(:sale_transaction) }
    it { is_expected.to have_many(:replies).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:rating) }
    it { should validate_inclusion_of(:rating).in_range(1..5) }
    it { should validate_presence_of(:comment) }
  end
end