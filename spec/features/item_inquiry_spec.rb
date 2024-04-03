require 'rails_helper'

feature 'Item Inquiry and Support' do
  given(:buyer) { create(:user) }
  given(:seller) { create(:user) }
  given(:item) { create(:item, seller: seller) }

  # Happy Path: Buyer Posts an Inquiry Successfully
  scenario 'Buyer communicates with seller on an item listing' do
    sign_in buyer
    visit item_path(item)
    fill_in 'Comment', with: 'Can you provide more details about the condition?'
    click_button 'Post Inquiry'
save_and_open_page
    expect(page).to have_content('Inquiry posted successfully.')
    expect(page).to have_content('Can you provide more details about the condition?')
  end

  # Happy Path: Seller Replies to an Inquiry
  scenario 'Seller replies to an inquiry on their item listing' do
    given!(:inquiry) { create(:inquiry, item: item, commenter: buyer, seller: seller) }

    sign_in seller
    visit item_path(item)

    click_link 'Reply' 
    fill_in 'Reply', with: 'The item is in mint condition, barely used.'
    click_button 'Post Reply'

    expect(page).to have_content('Reply posted successfully.')
    expect(page).to have_content('The item is in mint condition, barely used.')
  end

  # Sad Path: Must be logged in to comment on an item listing
  scenario 'must be logged in to comment on an item listing' do
    visit item_path(item)

    fill_in 'Inquiry', with: 'Can you provide more details about the condition?'
    click_button 'Post Inquiry'

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  # Sad Path: Posting an Inquiry with Invalid Data
  scenario 'Buyer attempts to post an inquiry with invalid data' do
    sign_in buyer
    visit item_path(item)

    # Assuming there's a validation on the presence of the comment content
    fill_in 'Inquiry', with: ''
    click_button 'Post Inquiry'

    expect(page).to have_content("Comment can't be blank")
  end
end
