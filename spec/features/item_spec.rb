require 'rails_helper'

RSpec.feature "Items", type: :feature do

  scenario "Merchant lists an item" do
    sign_in
    category = create(:category)    
    visit new_item_path

    fill_in "Name", with: "Test Item"
    fill_in "Description", with: "This is a test item description."
    fill_in "Starting price", with: 10.00
    select category.name, from: "Category"
    fill_in "Start date", with: Date.today
    fill_in "End date", with: Date.today + 7.days
    click_button "Create Item"

    expect(page).to have_text("Item was successfully created.")
    expect(page).to have_text("Test Item")
  end

#   scenario "Merchant views item details" do
#     item = create(:item, seller: user, category: category)

#     sign_in(user)
#     visit item_path(item)

#     expect(page).to have_text(item.name)
#     expect(page).to have_text(item.description)
#     expect(page).to have_text(item.starting_price)
#     expect(page).to have_text(item.start_date)
#     expect(page).to have_text(item.end_date)
#     expect(page).to have_text(item.status)
#   end

#   scenario "User views list of items" do
#     item1 = create(:item, seller: user, category: category, name: "Item 1")
#     item2 = create(:item, seller: user, category: category, name: "Item 2")

#     visit items_path

#     expect(page).to have_text(item1.name)
#     expect(page).to have_text(item2.name)
#   end
end
