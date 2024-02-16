
require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe 'associations' do
    it { should belong_to(:item) }
    it { should belong_to(:from_user).class_name('User') }
    it { should belong_to(:to_user).class_name('User') }
  end
end