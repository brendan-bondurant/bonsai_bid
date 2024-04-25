# require 'rails_helper'

# RSpec.feature "Auctions", type: :feature do
#   let(:user) { FactoryBot.create(:user) }
#   let(:category) { FactoryBot.create(:category) }
#   let(:item) { FactoryBot.create(:item, seller: user, category: category) }
#   let!(:auction) { FactoryBot.create(:auction, item: item, seller: user, starting_price: 100, bid_increment: 5, status: 'listed') }

#   before do
#     sign_in user
#   end

#   scenario "User creates an item and lists it for auction with default status listed" do
#     visit new_item_path
#     save_and_open_page
#     fill_in "Name", with: "Test Item"
#     fill_in "Description", with: "This is a test item description."
#     select category.name, from: "Category"
#     click_button "Create Item and Auction"

#     expect(page).to have_text("Item and associated auction were successfully created.")
#     expect(page).to have_text("Status: Listed")
#   end

#   scenario "User updates an existing auction to active" do
#     visit edit_auction_path(auction)
#     select 'Active', from: 'auction_status'
#     click_button "Update Auction"

#     expect(page).to have_content("Auction was successfully updated.")
#     expect(page).to have_content("Status: Active")
#   end

#   scenario "User attempts to create an auction with end date before start date" do
#     visit new_auction_path
#     select item.name, from: 'auction_item_id'
#     fill_in 'auction_start_date', with: 1.day.from_now
#     fill_in 'auction_end_date', with: 1.day.ago
#     fill_in 'auction_starting_price', with: 50
#     click_button "Create Auction"

#     expect(page).to have_text("End date must be after the start date")
#   end

#   scenario "User attempts to create an auction without a starting price" do
#     visit new_auction_path
#     select item.name, from: 'auction_item_id'
#     fill_in 'auction_start_date', with: 1.day.from_now
#     fill_in 'auction_end_date', with: 3.days.from_now
#     click_button "Create Auction"

#     expect(page).to have_text("Starting price is not a number")
#   end
# end
