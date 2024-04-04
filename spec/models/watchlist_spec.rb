require 'rails_helper'

RSpec.describe Watchlist, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:item) }
  end
end