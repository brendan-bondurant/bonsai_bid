require 'rails_helper'

feature 'Transaction History Features' do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:item) { create(:item, seller: user) }

  scenario 'Authenticated user views their own transaction history' do
    sign_in user
    create_list(:sale_transaction, 3, seller: user, buyer: other_user, item: item)
    create_list(:sale_transaction, 2, seller: other_user, buyer: user, item: item)
    
    visit user_sale_transactions_path(user)
    expected_path = "/users/#{user.id}/sale_transactions"
    expect(current_path).to eq(expected_path)
    expect(page).to have_selector('.transaction', count: 5)
  end

  scenario 'Authenticated user views another user\'s transaction history' do
    sign_in other_user
    create_list(:sale_transaction, 2, buyer: user, seller: other_user, item: item)
    create_list(:sale_transaction, 2, seller: user, buyer: other_user, item: item)
    
    visit user_sale_transactions_path(user)
    within '.sales-list' do
      expect(page).to have_selector('.transaction.sale', count: 2)
    end

    within '.purchases-list' do
      expect(page).to have_selector('.transaction.purchase', count: 2)
    end
    expect(page).to have_selector('.transaction', count: 4)
  end

  scenario 'Unauthenticated user attempts to view a user\'s transaction history' do
    create_list(:sale_transaction, 4, buyer: user, seller: other_user, item: item)
    
    visit user_sale_transactions_path(user)
    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'User views feedback for a transaction' do
    sign_in user
    sale_transaction = create(:sale_transaction, buyer: user, seller: other_user, item: item)
    feedback1 = create(:feedback, sale_transaction: sale_transaction, from_user: user, to_user: other_user, rating: 3, comment: "Good service.")
    feedback2 = create(:feedback, sale_transaction: sale_transaction, from_user: other_user, to_user: user, rating: 4, comment: "Prompt payment.")
    
    visit sale_transaction_feedbacks_path(sale_transaction)
    expect(page).to have_content(feedback1.comment)
    expect(page).to have_content(feedback2.comment)
    expect(page).to have_content("Rating: #{feedback1.rating}")
    expect(page).to have_content("Rating: #{feedback2.rating}")
  end
end
