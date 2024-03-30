require 'rails_helper'

feature 'Bidding Functionality' do
  let(:user) { create(:user) }
  let(:item) { create(:item) } # Assuming the item is part of an auction

  before do
    sign_in user
  end

  scenario 'User places a bid on an item' do
    visit item_path(item)

    fill_in 'Bid Amount', with: '100' # Assuming there's a field for the bid amount
    click_button 'Place Bid'

    expect(page).to have_content('Bid was successfully placed.')
    expect(page).to have_content('Current Bid: $100')
    # Verify that the current bidder is shown, adjust the text to match your application
    expect(page).to have_content("Current Bidder: #{user.email}")
  end

  scenario 'User is notified when outbid on an item' do
    # Place an initial bid
    create(:bid, item: item, user: user, amount: 100)

    # Another user outbids the first user
    other_user = create(:user)
    sign_out user
    sign_in other_user
    visit item_path(item)
    fill_in 'Bid Amount', with: '150'
    click_button 'Place Bid'

    # Assuming some mechanism to check notifications, like a notifications page or dropdown
    visit notifications_path(user)
    expect(page).to have_content("You were outbid on #{item.name}")
  end

  scenario 'User wins an auction' do
    # Place a bid that wins the auction
    visit item_path(item)
    fill_in 'Bid Amount', with: '200'
    click_button 'Place Bid'

    # Assuming the auction ends and the system determines the winner
    # This could be simulated or triggered within the test, depending on how auctions are handled
    # For the purpose of this test, assume a method 'end_auction' that finalizes the auction
    item.end_auction

    visit notifications_path(user)
    expect(page).to have_content("You won the auction for #{item.name}")
  end
end
