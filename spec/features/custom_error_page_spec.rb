RSpec.feature "General Error Handling", type: :feature do
  let(:user) { create(:user) }

  before do
    sign_in user
    allow(Item).to receive(:find).and_raise(StandardError)
  end

  scenario "User encounters an unexpected error" do
    visit item_path(999) # This ID triggers an error due to the mocked `find` method

    expect(page).to have_text("Something went wrong")
    expect(page).to have_current_path(error_path)
  end
end
