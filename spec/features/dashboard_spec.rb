require 'rails_helper'

RSpec.feature 'Dashboard - User Auctions and Watchlist', type: :feature do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:listed_item) { create(:item, seller: user) }
  let(:other_item) { create(:item, seller: other_user) }
  let!(:user_auction) { create(:auction, item: listed_item) }
  let!(:other_auction) { create(:auction, item: other_item) }

  before do
    login_as(user, scope: :user)
    # Simulating adding an auction to the watchlist; this could also be done directly if the link triggers an immediate action
    visit auction_path(other_auction)
    click_link 'Watch this Auction'
  end

  scenario 'User views their auctions and watched auctions on dashboard' do
    visit dashboard_user_path(user)

    # Checking for user's own auction
    expect(page).to have_content(user_auction.item.name)

    # Checking for an auction from another user that is being watched
    expect(page).to have_content(other_auction.item.name)
  end
end
