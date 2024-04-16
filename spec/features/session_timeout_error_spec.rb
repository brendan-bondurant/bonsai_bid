RSpec.feature "Session Timeout Handling", type: :feature do
  let(:user) { create(:user) }

  before do
    sign_in user
    # Assuming there's a method to simulate session timeout
    simulate_session_timeout
  end

  scenario "User's session times out and is redirected to login" do
    visit dashboard_path

    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_text("Your session has expired. Please log in again.")
  end
end
