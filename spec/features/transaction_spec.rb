require 'rails_helper'

feature 'Transaction History Features' do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:item) { create(:item, seller: user) }

  before do
    driven_by(:rack_test)  # Ensure you're using a driver that supports Capybara's page methods
  end

  scenario 'User views their comprehensive transaction history' do
    sign_in user
    create_list(:sale_transaction, 3, seller: user, buyer: other_user, item: item)
    create_list(:sale_transaction, 2, seller: other_user, buyer: user, item: item)
    
    visit user_transaction_history_path(user)
    expect(page).to have_selector('.transaction', count: 5)
  end

  scenario 'Anyone views a user\'s transaction history' do

    create_list(:sale_transaction, 2, buyer: user, seller: other_user, item: item)
    create_list(:sale_transaction, 2, seller: user, buyer: other_user, item: item)
    
    visit user_transaction_history_path(user)
    
    expect(page).to have_selector('.transaction', count: 4)
  end

  scenario 'User views feedback for a transaction' do
    sign_in user
    sale_transaction = create(:sale_transaction, buyer: user, seller: other_user, item: item)
    create(:feedback, sale_transaction: sale_transaction, from_user: user, to_user: other_user, rating: 3, comment: "Good service.")
    create(:feedback, sale_transaction: sale_transaction, from_user: other_user, to_user: user, rating: 4, comment: "Prompt payment.")
    
    visit sale_transaction_feedback_path(sale_transaction)
    
    expect(page).to have_content('Good service.')
    expect(page).to have_content('Prompt payment.')
    expect(page).to have_content('Rating: 3')
    expect(page).to have_content('Rating: 4')
  end
end
