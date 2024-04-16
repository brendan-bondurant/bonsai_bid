require 'rails_helper'

RSpec.feature "Auctions", type: :feature do
  let(:user) { create(:user) }
  let(:item) { create(:item, seller: user) }
  let!(:auction) { create(:auction, item: item, seller: user) }

  before do
    sign_in user
  end

  scenario "User creates an auction" do
    visit new_auction_path
    select "#{item.name}", from: "auction[item_id]"
    fill_in 'auction_start_date', with: '2024-01-01'
    fill_in 'auction_end_date', with: '2024-12-31'

    fill_in 'auction_starting_price', with: 50
    fill_in 'auction_bid_increment', with: 5
    click_button "Create Auction"

    expect(page).to have_text("Auction was successfully created.")
    expect(page).to have_text(item.name)
  end

  scenario "User places a bid on an auction" do
    visit auction_path(auction)
    fill_in "Bid amount", with: auction.starting_price + auction.bid_increment
    click_button "Place Bid"
    
    expect(page).to have_text("Bid was successfully placed.")
    expect(page).to have_text(auction.starting_price + auction.bid_increment)
  end

  scenario "User cannot create an auction with end date before start date" do
    visit new_auction_path
    select "#{item.name}", from: "auction[item_id]"
    fill_in 'auction_start_date', with: '2024-02-01'
    fill_in 'auction_end_date', with: '2024-01-01'

    fill_in 'auction_starting_price', with: 50
    fill_in 'auction_bid_increment', with: 5
    click_button "Create Auction"

    expect(page).to have_text("End date must be after the start date")
  end
end
