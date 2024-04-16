require 'rails_helper'

RSpec.describe Reply, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:respondable) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:content) }
  end
end
