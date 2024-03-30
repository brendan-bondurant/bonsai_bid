require 'rails_helper'

feature 'auto_bid' do


  scenario 'User sets up auto-bid for an item' do
    user = create(:user)
    sign_in user
    visit item_path(item)

    fill_in 'Auto-Bid Limit', with: '200'
    click_button 'Enable Auto-Bid'

    expect(page).to have_content('Auto-Bid enabled successfully.')
    # Assuming some indication on the page that auto-bid is active, like a status message or icon
    expect(page).to have_content('Auto-Bid Active')
  end
end
