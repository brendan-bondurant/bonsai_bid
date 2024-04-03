require 'rails_helper'

feature 'Item Inquiry and Support' do
  let(:buyer) { create(:user) }
  let(:seller) { create(:user) }
  let(:item) { create(:item, seller: seller) }



  scenario 'User accesses the contact page for inquiries and support' do
    visit contact_page_path 

    expect(page).to have_content('Contact Us')
    fill_in 'Email', with: buyer.email
    fill_in 'Message', with: 'I need help with a transaction.'
    click_button 'Send'

    expect(page).to have_content('Your inquiry has been sent.')
  end
end