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
    visit item_path(item)

    
    click_link "Watch this Item"
    expect(user.watchlists.count).to eq 1
    expect(page).to have_content(item.name)
    click_link item.name
    expect(current_path).to eq item_path(item)
  end

  scenario "User deletes an item from their watchlist" do
    create(:watchlist, item: item, user: user)

    visit user_watchlists_path(user)
    click_link "Delete" 
    
    expect(user.watchlists.count).to eq 0
    expect(page).to have_content "Watchlist was successfully destroyed." 
    expect(current_path).to eq dashboard_user_path(user)
  end
end
