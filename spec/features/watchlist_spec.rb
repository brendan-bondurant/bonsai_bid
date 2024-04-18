require 'rails_helper'

RSpec.feature "User's Watchlist Features", type: :feature do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:auction) { create(:auction, seller: other_user) }
  let!(:other_auction) { create(:auction, seller: user) }

  before do
    login_as(user, scope: :user)
  end

  scenario "User views only their watchlist items" do
    create(:watchlist, auction: auction, user: user)

    create(:watchlist, auction: other_auction, user: other_user)
    visit user_watchlists_path(user.id)

    expect(page).to have_content auction.name
    expect(page).to_not have_content other_auction.name
  end

  scenario "User adds an item to their watchlist" do
    visit item_path(item)

    
    click_link "Watch this Item"
    expect(user.watchlists.count).to eq 1
    expect(page).to have_content(item.name)
    click_link item.name
    expect(current_path).to eq item_path(item)
  end

  scenario "User deletes an item from their watchlist" do
    create(:watchlist, auction: auction, user: user)

    visit user_watchlists_path(user)
    click_link "Delete" 
    
    expect(user.watchlists.count).to eq 0
    expect(page).to have_content "Watchlist was successfully destroyed." 
    expect(current_path).to eq dashboard_user_path(user)
  end
end
