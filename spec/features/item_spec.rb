require 'rails_helper'

RSpec.feature "Items", type: :feature do

  scenario "User lists an item" do
    sign_in_w_form
    category = create(:category)  
    visit new_item_path

    fill_in "Name", with: "Test Item"
    fill_in "Description", with: "This is a test item description."
    select category.name, from: "Category"
    
    click_button "Create Item"

    expect(page).to have_text("Item was successfully created.")
    expect(page).to have_text("Test Item")
  end

  scenario "View item details" do

    user_with_items
    visit item_path(@item1)
    expect(page).to have_text(@item1.name)
    expect(page).to have_text(@item1.description)
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
    user1 = FactoryBot.create(:user)  
    user_with_items
    category = create(:category)
    item = Item.create!(
      name: "Test Item 4",
      description: "Bonsai Tree",
      category: category,
      seller: user1,
      status: 'listed',
    ) 
    visit edit_item_path(item)
    
    expect(current_path).to eq(root_path)
    expect(page).to have_content("You are not authorized to perform this action.") 
  end

  scenario "Unauthenticated user views an item" do
    user1 = FactoryBot.create(:user)  
    user_with_items
    category = create(:category)
    item = Item.create!(
      name: "Test Item 4",
      description: "Bonsai Tree",
      category: category,
      seller: user1,
      status: 'listed',
    ) 
    visit item_path(item)
    expect(page).to have_content(item.name)
    expect(page).to_not have_link('Edit')
    expect(page).to_not have_link('Delete')
  end

  scenario "Authenticated user who is not the seller views an item" do
    user1 = FactoryBot.create(:user)     
    user_with_items
    category = create(:category)
    item = Item.create!(
      name: "Test Item 4",
      description: "Bonsai Tree",
      category: category,
      seller: user1,
      status: 'listed',
    ) 
    non_seller = FactoryBot.create(:user, id: 8787)
    login_as(non_seller, scope: :user)
    visit item_path(item)
    expect(page).to have_content(item.name)
    expect(page).to_not have_link('Edit')
    expect(page).to_not have_link('Delete')
  end

  scenario "Authenticated seller views their item" do
    user1 = FactoryBot.create(:user)   
    user_with_items
    category = create(:category)
    item = Item.create!(
      name: "Test Item 4",
      description: "Bonsai Tree",
      category: category,
      seller: user1,
      status: 'listed',
    ) 
    login_as(item.seller, scope: :user)
    visit item_path(item)
    
    expect(page).to have_content(item.name)
    expect(page).to have_link('Edit')
    expect(page).to have_link("Remove #{item.name}")
  end



  scenario "User views all items" do
    user_with_items 
    visit items_path
    Item.all.each do |item|
      expect(page).to have_text(item.name)
      expect(page).to have_text(item.description)
    end
  end

  scenario "User submits invalid data for new item" do
    sign_in_w_form
    visit new_item_path
    fill_in "Name", with: ""  
    click_button "Create Item"
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Category must exist")
    expect(page).to have_content("Description can't be blank")
  end
  
  scenario "Unauthenticated user tries to create a new item" do
    visit new_item_path
    expect(current_path).to eq(new_user_session_path) 
    expect(page).to have_content("You must be logged in")
  end  
end
