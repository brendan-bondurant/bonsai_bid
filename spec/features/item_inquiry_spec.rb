require 'rails_helper'

RSpec.feature 'Auction Inquiry and Support', type: :feature do
  given(:buyer) { create(:user) }
  given(:seller) { create(:user) }
  given(:item) { create(:item, seller: seller) }
  given(:auction) { create(:auction, item: item) }

  scenario 'Buyer communicates with seller on an auction listing' do
    sign_in buyer
    visit auction_path(auction)
    fill_in 'Comment', with: 'Can you provide more details about the condition?'
    click_button 'Post Inquiry'
    expect(page).to have_content('Inquiry posted successfully.')
    expect(page).to have_content('Can you provide more details about the condition?')
  end

  context 'with existing inquiry' do
    given!(:inquiry) { create(:inquiry, auction: auction, commenter: buyer, seller: seller) }

    scenario 'Seller replies to an inquiry on their auction listing' do
      sign_in seller
      visit auction_path(auction)
      
      fill_in 'Content', with: 'The item is in mint condition, barely used.'
      click_button 'Reply'
      expect(page).to have_content('Reply was successfully created.')
      expect(page).to have_content('The item is in mint condition, barely used.')
    end
  end

  scenario 'Inquiry form is not visible to users who are not logged in' do
    visit auction_path(auction)
  
    expect(page).not_to have_field('Comment')
    expect(page).not_to have_button('Post Inquiry')
  end

  # Sad Path: Posting an Inquiry with Invalid Data
  scenario 'Buyer attempts to post an inquiry with invalid data' do
    sign_in buyer
    visit auction_path(auction)
    
    fill_in 'Comment', with: ''
    click_button 'Post Inquiry'
    expect(page).to have_content("Comment can't be blank")
  end
end
