require 'rails_helper'



feature 'Advanced Item and Auction Features' do
  let(:merchant) { create(:user) }
  let(:item) { create(:item, seller: merchant, minimum_bid_price: 100, bid_increment: 10) }

  scenario 'Merchant sets minimum bid price and bid increments for an auction' do
    sign_in merchant
    visit edit_item_path(item)

    fill_in 'Minimum Bid Price', with: '100'
    fill_in 'Bid Increment', with: '10'
    click_button 'Update Item'

    expect(page).to have_content('Item updated successfully.')
    expect(page).to have_content('Minimum Bid Price: $100')
    expect(page).to have_content('Bid Increment: $10')
  end
end
