require 'rails_helper'

feature 'Feedback and Transaction Features' do
  let(:buyer) { create(:user) }
  let(:seller) { create(:user) }
  let(:item) { create(:item, seller: seller) }

  before do
    sign_in buyer
  end

  scenario 'User views a transaction with ratings' do
    sale_transaction = create(:sale_transaction, buyer: buyer, seller: seller, item: item)
    create(:feedback, sale_transaction: sale_transaction, from_user: buyer, to_user: seller, item: item, rating: 5)
    create(:feedback, sale_transaction: sale_transaction, from_user: seller, to_user: buyer, item: item, rating: 4)
    visit sale_transaction_path(sale_transaction)
    expect(page).to have_content('Rating')
    expect(page).to have_content('5') 
    expect(page).to have_content('4') 
  end

  scenario 'User views a seller profile with rating and history' do
    sale_transaction = create(:sale_transaction, seller: seller, buyer: buyer, item: item)
    create(:feedback, sale_transaction: sale_transaction, rating: 4)
    visit profile_user_path(seller)
    expect(page).to have_content('Rating: 4')
  end

  scenario 'from_user edits their feedback' do
    sign_in buyer
    sale_transaction = create(:sale_transaction, seller: seller, buyer: buyer, item: item)
    feedback = create(:feedback, sale_transaction: sale_transaction, from_user: buyer, to_user: seller, item: item, comment: "Initial comment")

    visit edit_feedback_path(feedback)
    fill_in 'Comment', with: 'Updated comment'
    click_button 'Update Feedback'

    expect(page).to have_content('Feedback was successfully updated')
    expect(page).to have_content('Updated comment')
  end
end

