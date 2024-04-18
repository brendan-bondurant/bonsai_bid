require 'rails_helper'

RSpec.feature "Create Items with Auctions", type: :feature do
  let!(:user) { FactoryBot.create(:user) }
  let!(:category) { FactoryBot.create(:category) }

  before do
    sign_in user
  end

  scenario "User successfully creates an item with images and an auction" do
    visit new_item_path

    fill_in "Name", with: "New Camera"
    fill_in "Description", with: "A brand new DSLR camera"
    select category.name, from: "Category"
    attach_file 'Images', [Rails.root.join('spec', 'fixtures', 'files', 'image1.jpg'), Rails.root.join('spec', 'fixtures', 'files', 'image2.jpg')]
    
    fill_in "Start Time", with: DateTime.now + 3.days
    fill_in "End Time", with: DateTime.now + 10.days
    select "Listed", from: "Status"

    click_button "Create Item and Auction"

    expect(page).to have_content("Item and associated auction were successfully created.")
    expect(Item.last.images.count).to eq(2)
    expect(Auction.last.status).to eq("listed")
  end

  scenario "User fails to create an item due to missing required fields" do
    visit new_item_path

    click_button "Create Item and Auction"

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Category must exist")
  end
end
