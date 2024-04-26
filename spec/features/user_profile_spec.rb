require 'rails_helper'

RSpec.feature "UserProfiles", type: :feature do
  let!(:user) { create(:user) }
  let!(:second_user) { create(:user) }
  let!(:user_profile) { create(:user_profile, user: user) } 
  let!(:second_user_profile) { create(:user_profile, user: second_user) } 

  before do
    sign_in user
  end

  scenario "User views their profile" do
    visit user_profile_path(user_profile) 
save_and_open_page
    expect(page).to have_text(user_profile.name)
    expect(page).to have_text(user_profile.phone)
  end

  scenario "User views another user's profile" do
    visit user_profile_path(second_user_profile)
    expect(page).to have_text(second_user_profile.name)
    expect(page).to have_text(second_user_profile.phone)  
    expect(current_path).to eq(user_profile_path(second_user_profile))
  end

  scenario "User updates their profile with valid information" do
    visit edit_user_profile_path(user_profile) 

    fill_in "Name", with: "Updated Name"
    fill_in "Phone", with: "1234567890"
    click_button "Update Profile"

    expect(page).to have_text("Profile was successfully updated.")
    user_profile.reload
    expect(page).to have_text("Updated Name")
    expect(page).to have_text("1234567890")
  end

  scenario "User tries to update their profile with invalid information" do
    visit edit_user_profile_path(user_profile) 

    fill_in "Name", with: "" 
    click_button "Update Profile"

    expect(page).to have_text("Name can't be blank") 
  end
end
