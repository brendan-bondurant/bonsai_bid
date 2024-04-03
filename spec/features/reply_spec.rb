require 'rails_helper'

RSpec.feature 'Feedback Reply Management', type: :feature do
  let!(:seller) { create(:user) }
  let!(:buyer) { create(:user) }
  let!(:item) { create(:item, seller: seller) }
  let!(:sale_transaction) { create(:sale_transaction, seller: seller, buyer: buyer, item: item) }
  let!(:feedback) { create(:feedback, sale_transaction: sale_transaction, from_user: buyer, to_user: seller, item: item, comment: "Needs improvement") }

  scenario 'Complete feedback reply flow' do
    sign_in seller
    visit sale_transaction_feedback_path(sale_transaction,feedback)
    save_and_open_page
    fill_in 'Reply', with: 'Thank you for your feedback, we will improve.'
    click_button 'Post Reply'
    expect(page).to have_content('Reply posted.')
    expect(page).to have_content('Thank you for your feedback, we will improve.')

    sign_out seller
    sign_in buyer
    visit sale_transaction_feedbacks_path(feedback)
    fill_in 'Reply', with: 'Appreciate the prompt response and efforts!'
    click_button 'Post Reply'
    expect(page).to have_content('Reply posted.')
    expect(page).to have_content('Appreciate the prompt response and efforts!')

    sign_out buyer
    sign_in seller
    visit sale_transaction_feedbacks_path(feedback)
    fill_in 'Reply', with: 'We have implemented the suggested improvements.'
    click_button 'Post Reply'
    expect(page).to have_content('Reply posted.')
    expect(page).to have_content('We have implemented the suggested improvements.')

    within first('.reply') do  
      click_link 'Edit'
      fill_in 'Reply', with: 'Updated: Thank you for your valuable feedback, we are making improvements.'
      click_button 'Update Reply'
      expect(page).to have_content('Reply updated.')
      expect(page).to have_content('Updated: Thank you for your valuable feedback, we are making improvements.')
    end

    within all('.reply').last do  
      click_link 'Delete'
    end
    expect(page).to have_content('Reply deleted.')
    expect(page).not_to have_content('We have implemented the suggested improvements.')
  end
end
