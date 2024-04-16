require 'rails_helper'

feature 'Dashboard - User Items and watchlist' do
  scenario 'User views listed and watched items on dashboard' do
    user = create(:user)    
    other_user = create(:user)  
    listed_item = create(:item, seller: user)
    other_item = create(:item, seller: other_user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit item_path(other_item)
    click_link 'Watch this Item'
    visit dashboard_user_path(user)
    expect(page).to have_content(listed_item.name)
    
    expect(page).to have_content(other_item.name)
  end
end
