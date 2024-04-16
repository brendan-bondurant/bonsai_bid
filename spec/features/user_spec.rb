require 'rails_helper'
require 'benchmark'

RSpec.feature "Users", type: :feature do
  let!(:test_user) { create(:user, email: "testuser@example.com", password: "password") }

  
  scenario "User signs up with valid information including address details" do
    visit new_user_registration_path
    
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    fill_in "Confirm Password", with: "password123"
    fill_in "Street", with: "123 Test St"
    fill_in "City", with: "Testville"
    fill_in "State", with: "TS"
    fill_in "Zip", with: "12345"
    fill_in "Name", with: "Please Work"
    fill_in "Phone", with: "1231231234"
    click_button "Sign Up"
    
    expect(page).to have_text("Welcome! You have signed up successfully.")
  
    user = User.find_by(email: "test@example.com")
    expect(user.street).to eq("123 Test St")
    expect(user.city).to eq("Testville")
    expect(user.state).to eq("TS")
    expect(user.zip).to eq("12345")
    expect(user.name).to eq(user.user_profile.name)
    expect(user.user_profile.phone).to eq("1231231234")
  end
  
  

  scenario "User signs up with invalid address information" do
    visit new_user_registration_path
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    fill_in "Confirm Password", with: "password123"
    fill_in "Street", with: "" 
    click_button "Sign Up"
    expect(page).to have_text("Street can't be blank")
  end
  

  scenario "User logs in with valid credentials" do
    user = create(:user, email: "test@example.com", password: "password")

    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "password"
    click_button "Log in"

    expect(page).to have_text("Signed in successfully.")
  end

  scenario "User logs in with invalid credentials" do
    visit new_user_session_path
    fill_in "user_email", with: "nonexistent@example.com"
    fill_in "user_password", with: "invalidpassword"
    click_button "Log in"
    expect(page).to have_text("Invalid Email or password.")
  end

  scenario "User views their items" do
    user_with_items

    visit user_path(@user.id)
    expect(page).to have_text(@item1.name)
    expect(page).to have_text(@item2.name)
    expect(page).to have_text(@item3.name)
  end

  scenario "User updates profile with valid address information" do
    sign_in test_user
    visit edit_user_registration_path
    fill_in "Street", with: "456 New St"
    fill_in "Current password", with: test_user.password
    click_button "Update"
    
    expect(page).to have_text("Your account has been updated successfully.")
    test_user.reload
    expect(test_user.street).to eq("456 New St")
  end

  scenario "User updates profile with invalid information" do

    sign_in test_user
    visit edit_user_registration_path
    fill_in "user_email", with: "invalid_email"
    fill_in "user_current_password", with: test_user.password
    click_button "Update"
    expect(page).to have_text("1 error prohibited this user from being saved:")
    expect(page).to have_text("Email is invalid")
  end

  scenario "User deletes account" do
    sign_in test_user
    visit edit_user_registration_path
    click_button "Cancel my account"
    expect(page).to have_text("Bye! Your account has been successfully cancelled. We hope to see you again soon.")
  end
end
