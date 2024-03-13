require 'rails_helper'

feature 'Dashboard - User Items and Favorites' do
  scenario 'User views listed and favorited items on dashboard' do
    user = create(:user)
    other_user = create(:user)
    listed_item = create(:item, seller: user)
    other_item = create(:item, seller: other_user)

    # User logs in
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    # User favorites an item
    visit item_path(other_item)
    click_button 'Favorite'

    # User visits dashboard
    visit dashboard_path(user)

    # Expect to see listed item
    expect(page).to have_content(listed_item.name)

    # Expect to see favorited item
    expect(page).to have_content(other_item.name)
  end
end