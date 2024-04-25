# require 'rails_helper'

# RSpec.feature "Session Timeout Handling", type: :feature do
#   let(:user) { create(:user) }

#   before do
#     sign_in user
#     simulate_session_timeout
#   end
  
#   def simulate_session_timeout
#     visit dashboard_user_path(user)
#     Capybara.current_session.driver.request.env['rack.session']['warden.user.user.session'] = { last_request_at: 31.minutes.ago }
#   end
  

#   scenario "User's session times out at 30 minutes and is redirected to login" do
#     visit dashboard_user_path(user)
#     expect(page).to have_current_path(new_user_session_path)
#     expect(page).to have_text("Your session has expired. Please log in again.")
#   end
# end
