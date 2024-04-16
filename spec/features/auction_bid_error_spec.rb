RSpec.feature "Auction Bid Error Handling", type: :feature do
  let(:user) { create(:user) }
  let(:auction) { create(:auction) }

  before do
    sign_in user
    allow_any_instance_of(Bid).to receive(:save).and_return(false)
  end

  scenario "Database error occurs while placing a bid" do
    visit auction_path(auction)
    fill_in "Bid amount", with: 100
    click_button "Place Bid"

    expect(page).to have_text("Failed to place bid due to a system error.")
    expect(Bid.count).to eq 0
  end
end
