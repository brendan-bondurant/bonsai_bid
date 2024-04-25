require 'rails_helper'

feature 'Feedback and Transaction Features' do
  let(:buyer) { create(:user) }
  let(:seller) { create(:user) }
  let(:item) { create(:auction, seller: seller) }

  before do
    sign_in buyer
  end

  scenario 'User views a transaction with ratings' do
    sale_transaction = create(:sale_transaction, buyer: buyer, seller: seller, auction: item)
    create(:feedback, sale_transaction: sale_transaction, from_user: buyer, to_user: seller, auction: item, rating: 5)
    create(:feedback, sale_transaction: sale_transaction, from_user: seller, to_user: buyer, auction: item, rating: 4)
    visit sale_transaction_path(sale_transaction)
    expect(page).to have_content('Rating')
    expect(page).to have_content('5') 
    expect(page).to have_content('4') 
  end

  scenario 'User views a seller profile with rating and history' do
    sale_transaction = create(:sale_transaction, seller: seller, buyer: buyer, auction: item)
    create(:feedback, sale_transaction: sale_transaction, rating: 4)
    visit profile_user_path(seller)
    expect(page).to have_content('Rating: 4')
  end

  scenario 'from_user edits their feedback' do
    sign_in buyer
    sale_transaction = create(:sale_transaction, seller: seller, buyer: buyer, auction: item)
    feedback = create(:feedback, sale_transaction: sale_transaction, from_user: buyer, to_user: seller, auction: item, comment: "Initial comment")

    visit edit_feedback_path(feedback)
    fill_in 'Comment', with: 'Updated comment'
    click_button 'Update Feedback'

    expect(page).to have_content('Feedback was successfully updated')
    expect(page).to have_content('Updated comment')
  end

  scenario 'from_user fails to update their feedback due to invalid data' do
    sign_in buyer
    sale_transaction = create(:sale_transaction, seller: seller, buyer: buyer, auction: item)
    feedback = create(:feedback, sale_transaction: sale_transaction, from_user: buyer, to_user: seller, auction: item, comment: "Initial comment")
  
    visit profile_user_path(seller)
    
    click_link 'Edit Feedback'
    fill_in 'Comment', with: '' 
    click_button 'Update Feedback'
    save_and_open_page
    expect(page).to have_content("Comment can't be blank") 
    expect(page).to have_content('Initial comment') 
  end
  
  scenario 'user successfully deletes their feedback' do
    sign_in buyer
    sale_transaction = create(:sale_transaction, seller: seller, buyer: buyer, auction: item)
    feedback = create(:feedback, sale_transaction: sale_transaction, from_user: buyer, to_user: seller, auction: item, comment: "Removable comment")
  
    visit profile_user_path(seller) 
    click_link 'Delete Feedback', match: :first
  
    expect(page).to have_content('Feedback was successfully destroyed.')
    expect(page).not_to have_content('Removable comment')
  end

  scenario 'user fails to delete feedback due to permissions' do
    another_user = create(:user)
    sign_in another_user 
    sale_transaction = create(:sale_transaction, seller: seller, buyer: buyer, auction: item)
    feedback = create(:feedback, sale_transaction: sale_transaction, from_user: buyer, to_user: seller, auction: item)
  
    visit profile_user_path(seller)
    expect(page).not_to have_link('Delete Feedback') 
  
    expect(Feedback.exists?(feedback.id)).to be true 
  end
  
end

