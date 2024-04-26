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
    expect(page).to have_content auction.item.name
    expect(page).to_not have_content other_auction.item.name
  end

  scenario "User adds an auction to their watchlist" do
    visit auction_path(auction)

    click_link "Watch this Auction"
    expect(user.watchlists.count).to eq 1
    expect(page).to have_content(auction.item.name)
    click_link auction.item.name
    expect(current_path).to eq auction_path(auction)
  end

  scenario "User deletes an auction from their watchlist" do
    create(:watchlist, auction: auction, user: user)

    visit user_watchlists_path(user)
    click_link "Delete" 
    
    expect(user.watchlists.count).to eq 0
    expect(page).to have_content "Watchlist was successfully destroyed." 
    expect(current_path).to eq dashboard_user_path(user)
  end

  scenario "User fails to add an item to their watchlist due to validation errors" do
    create(:watchlist, auction: auction, user: user)  
    visit auction_path(auction)
    expect(user.watchlists.count).to eq 1  # Count remains the same because the new addition fails
    
    click_link "Watch this Auction"
  
    expect(user.watchlists.count).to eq 1  # Count remains the same because the new addition fails
    expect(page).to have_content("Auction has already been added to your watchlist")  # Expecting some error feedback on the page
  end
  
end
