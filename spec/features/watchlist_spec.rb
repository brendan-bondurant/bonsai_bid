require 'rails_helper'

RSpec.feature "User's Watchlist Features", type: :feature do
  let!(:user) { create(:user, id: 12) }
  let!(:other_user) { create(:user, id: 13) }
  let!(:item) { create(:item, seller: other_user, id: 14) }
  let!(:other_item) { create(:item, seller: user, id: 15) }

  before do
    login_as(user, scope: :user)
  end

  scenario "User views only their watchlist items" do
    create(:watchlist, item: item, user: user)

    create(:watchlist, item: other_item, user: other_user)
    visit user_watchlists_path(user.id)

    expect(page).to have_content item.name
    expect(page).to_not have_content other_item.name
  end

  scenario "User adds an item to their watchlist" do
    visit new_watchlist_path

    select item.name, from: "Item" # Adjust based on your form
    click_button "Add to Watchlist"

    expect(user.watchlists.count).to eq 1
    expect(page).to have_content "Item successfully added to your watchlist"
  end

  scenario "User updates an item in their watchlist" do
    watchlist = create(:watchlist, user: user)
    new_item = create(:item)

    visit edit_watchlist_path(watchlist)

    select new_item.name, from: "Item" # Adjust based on your form
    click_button "Update Watchlist"

    expect(watchlist.reload.item).to eq new_item
    expect(page).to have_content "Watchlist was successfully updated."
  end

  scenario "User deletes an item from their watchlist" do
    watchlist = create(:watchlist, user: user)

    visit user_watchlist_path(user) 
    click_link "Delete" 

    expect(user.watchlists.count).to eq 0
    expect(page).to have_content "Watchlist was successfully removed." 
  end
end
