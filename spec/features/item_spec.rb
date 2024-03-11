require 'rails_helper'

RSpec.feature "Items", type: :feature do

  scenario "User lists an item" do
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
  
  scenario "User updates an existing item" do
    user_with_items
    visit edit_item_path(@item2)
    fill_in "Name", with: "Updated Name"
    select 'Active', from: 'Status'
    click_button "Update Item"

    expect(page).to have_content("Item was successfully updated.")
    expect(page).to have_content("Updated Name")
  end

  scenario "User deletes an item" do
    user_with_items
    visit item_path(@item2)
    click_link "Remove #{(@item2.name)}"

    expect(current_path).to eq(items_path)

    expect(page).to have_content("Item was successfully destroyed.")
    expect(page).not_to have_content(@item2.name)
  end

  scenario "User submits invalid update data" do
    user_with_items
    visit edit_item_path(@item2)
    fill_in "Name", with: "" 
    click_button "Update Item"
    
    
    expect(page).to have_content("Name can't be blank") 
    expect(@item2.reload.name).to eq(@item2.name) 
  end

  scenario "Unauthorized user attempts to update item" do
    user1 = User.create!(id: 321, email: "test@test.com", password: "password", name: "test", address: 'test street', phone: 9876543212 )  
    user_with_items
    category = create(:category)
    item = Item.create!(
      id: 126,
      name: "Test Item 4",
      description: "Bonsai Tree",
      starting_price: 20.00,
      current_price: 20.00,
      buy_it_now_price: 40.00,
      category: category,
      seller: user1,
      status: 'listed',
      start_date: Date.today,
      end_date: Date.today + 10.days
    ) 
    visit edit_item_path(item)
    
    expect(current_path).to eq(root_path)
    expect(page).to have_content("You are not authorized to perform this action.") 
  end

  scenario "Unauthenticated user views an item" do
    user1 = User.create!(id: 321, email: "test@test.com", password: "password", name: "test", address: 'test street', phone: 9876543212 )  
    user_with_items
    category = create(:category)
    item = Item.create!(
      id: 126,
      name: "Test Item 4",
      description: "Bonsai Tree",
      starting_price: 20.00,
      current_price: 20.00,
      buy_it_now_price: 40.00,
      category: category,
      seller: user1,
      status: 'listed',
      start_date: Date.today,
      end_date: Date.today + 10.days
    ) 
    visit item_path(item)
    expect(page).to have_content(item.name)
    expect(page).to_not have_link('Edit')
    expect(page).to_not have_link('Delete')
  end

  scenario "Authenticated user who is not the seller views an item" do
    user1 = User.create!(id: 321, email: "test@test.com", password: "password", name: "test", address: 'test street', phone: 9876543212 )  
    user_with_items
    category = create(:category)
    item = Item.create!(
      id: 126,
      name: "Test Item 4",
      description: "Bonsai Tree",
      starting_price: 20.00,
      current_price: 20.00,
      buy_it_now_price: 40.00,
      category: category,
      seller: user1,
      status: 'listed',
      start_date: Date.today,
      end_date: Date.today + 10.days
    ) 
    non_seller = FactoryBot.create(:user)
    login_as(non_seller, scope: :user)
    visit item_path(item)
    expect(page).to have_content(item.name)
    expect(page).to_not have_link('Edit')
    expect(page).to_not have_link('Delete')
  end

  scenario "Authenticated seller views their item" do
    user1 = User.create!(id: 321, email: "test@test.com", password: "password", name: "test", address: 'test street', phone: 9876543212 )  
    user_with_items
    category = create(:category)
    item = Item.create!(
      id: 126,
      name: "Test Item 4",
      description: "Bonsai Tree",
      starting_price: 20.00,
      current_price: 20.00,
      buy_it_now_price: 40.00,
      category: category,
      seller: user1,
      status: 'listed',
      start_date: Date.today,
      end_date: Date.today + 10.days
    ) 
    login_as(item.seller, scope: :user)
    visit item_path(item)
    
    expect(page).to have_content(item.name)
    expect(page).to have_link('Edit')
    expect(page).to have_link("Remove #{item.name}")
  end
end
