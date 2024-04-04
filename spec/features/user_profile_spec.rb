RSpec.feature "UserProfiles", type: :feature do
  let!(:user) { create(:user, email: "testuser@example.com", password: "password") }
  let!(:user_profile) { create(:user_profile, user: user, name: "Original Name") }

  before do
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "password"
    click_button "Log in"
  end

  scenario "User updates profile with valid information" do
    visit edit_user_profile_path(user_profile)
    fill_in "user_profile_name", with: "Updated Name"
    click_button "Update Profile"
    
    expect(page).to have_text("Profile updated successfully.")
    expect(user.user_profile.reload.name).to eq("Updated Name")
  end

  scenario "User updates profile with invalid information" do
    visit edit_user_profile_path(user_profile)
    fill_in "user_profile_phone", with: "invalid phone number"
    click_button "Update Profile"
    
    expect(page).to have_text("1 error prohibited this profile from being saved:")
    expect(page).to have_text("Phone is invalid")
  end
end
