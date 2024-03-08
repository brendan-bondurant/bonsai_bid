require 'rails_helper'

RSpec.feature "Items", type: :feature do

  scenario "Merchant lists an item" do
    sign_in_w_form
    category = create(:category)  
    visit new_item_path

    fill_in "Name", with: "Test Item"
    fill_in "Description", with: "This is a test item description."
    fill_in "Starting price", with: 10.00
    fill_in "Buy it now price", with: 30.00
    select category.name, from: "Category"
    fill_in "Start date", with: Date.today
    fill_in "End date", with: Date.today + 7.days
    
    click_button "Create Item"

    expect(page).to have_text("Item was successfully created.")
    expect(page).to have_text("Test Item")
  end

  scenario "View item details" do

    user_with_items
    visit item_path(@item1)
    expect(page).to have_text(@item1.name)
    expect(page).to have_text(@item1.description)
    expect(page).to have_text(@item1.starting_price)
    expect(page).to have_text(@item1.start_date)
    expect(page).to have_text(@item1.end_date)
    expect(page).to have_text(@item1.status)
  end


end
