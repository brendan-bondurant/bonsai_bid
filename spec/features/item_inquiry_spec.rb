require 'rails_helper'

feature 'Item Inquiry and Support' do
  let(:buyer) { create(:user) }
  let(:seller) { create(:user) }
  let(:item) { create(:item, seller: seller) }

  scenario 'Buyer communicates with seller on an item listing' do
    sign_in buyer
    visit item_path(item)

    fill_in 'Inquiry', with: 'Can you provide more details about the condition?'
    click_button 'Post Inquiry'

    expect(page).to have_content('Inquiry posted successfully.')
    expect(page).to have_content('Can you provide more details about the condition?')
    # This expects inquiries to be displayed on the item listing page like comments
  end

  scenario 'User accesses the contact page for inquiries and support' do
    visit contact_page_path # Assuming there's a route named `contact_page_path`

    expect(page).to have_content('Contact Us')
    fill_in 'Email', with: buyer.email
    fill_in 'Message', with: 'I need help with a transaction.'
    click_button 'Send'

    expect(page).to have_content('Your inquiry has been sent.')
  end
end