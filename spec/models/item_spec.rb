require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it { should belong_to(:seller).class_name('User') }
    it { should belong_to(:category) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

  # describe 'status enum' do
  #   it 'is defined within the Item model' do
  #     is_expected.to define_enum_for(:status).
  #       with_values(listed: 0, active: 1, sold: 2, ended: 3)
  #   end
  # end
end