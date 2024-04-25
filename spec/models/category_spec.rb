require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { should have_many(:items) }
    it { should belong_to(:parent).class_name('Category').optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    # it { should validate_presence_of(:description) }
  end
end