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
    create(:feedback, sale_transaction: sale_transaction, rating: 5)

    visit sale_transaction_path(sale_transaction)
    expect(page).to have_content('Rating')
    expect(page).to have_content('★★★★★') # Adjust based on your rating display
  end

  scenario 'Buyer views their transaction history' do
    create_list(:sale_transaction, 3, buyer: buyer, seller: seller, item: item)

    visit transaction_history_path(buyer)
    expect(page).to have_selector('.transaction', count: 3)
  end

  scenario 'Seller views their selling history' do
    create_list(:sale_transaction, 5, seller: seller, buyer: buyer, item: item)

    sign_out buyer
    sign_in seller

    visit selling_history_path(seller)
    expect(page).to have_selector('.sale', count: 5)
  end

  scenario 'User views a seller profile with rating and history' do
    sale_transaction = create(:sale_transaction, seller: seller, buyer: buyer, item: item)
    create(:feedback, sale_transaction: sale_transaction, rating: 4)

    visit user_profile_path(seller)
    expect(page).to have_content('Rating: ★★★★☆')
    expect(page).to have_link('View Selling History')
  end
end
