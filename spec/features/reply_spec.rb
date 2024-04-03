require 'rails_helper'

RSpec.feature 'Feedback Reply Management', type: :feature do
  let!(:seller) { create(:user) }
  let!(:buyer) { create(:user) }
  let!(:item) { create(:item, seller: seller) }
  let!(:sale_transaction) { create(:sale_transaction, seller: seller, buyer: buyer, item: item) }
  let!(:feedback) { create(:feedback, sale_transaction: sale_transaction, from_user: buyer, to_user: seller, item: item, comment: "Needs improvement") }
  let!(:reply) { create(:reply, feedback: feedback, author: seller, content: "Initial reply content") }

  scenario 'Complete feedback reply flow' do
    sign_in seller
    visit sale_transaction_feedback_path(sale_transaction,feedback)
    fill_in 'Reply', with: 'Thank you for your feedback, we will improve.'
    click_button 'Post Reply'
    
    expect(page).to have_content('Reply was successfully created.')
    expect(page).to have_content('Thank you for your feedback, we will improve.')

    sign_out seller
    sign_in buyer
    visit sale_transaction_feedback_path(sale_transaction,feedback)
    fill_in 'Reply', with: 'Appreciate the prompt response and efforts!'
    click_button 'Post Reply'
    expect(page).to have_content('Reply was successfully created.')
    expect(page).to have_content('Appreciate the prompt response and efforts!')

    sign_out buyer
    sign_in seller
    visit sale_transaction_feedback_path(sale_transaction,feedback)
    fill_in 'Reply', with: 'We have implemented the suggested improvements.'
    click_button 'Post Reply'
    expect(page).to have_content('Reply was successfully created.')
    expect(page).to have_content('We have implemented the suggested improvements.')
  end
  scenario 'Seller edits a reply' do
    sign_in seller
    visit edit_sale_transaction_feedback_reply_path(sale_transaction, feedback, reply)
    
    fill_in 'reply_content', with: 'Updated: Thank you for your valuable feedback, we are making improvements.'
    click_button 'Update Reply'

    expect(page).to have_content('Reply was successfully updated.')
    expect(page).to have_content('Updated: Thank you for your valuable feedback, we are making improvements.')
  end

  scenario 'Seller deletes a reply' do
    sign_in seller
    visit sale_transaction_feedback_path(sale_transaction, feedback)
    
    expect(page).to have_content("Initial reply content")

    within first('.reply') do  
      click_link 'Delete Reply'
    end

    expect(page).to have_content('Reply deleted.')
    expect(page).not_to have_content("Initial reply content")
  end
end

