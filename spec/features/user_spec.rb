require 'rails_helper'
require 'benchmark'

RSpec.feature "Users", type: :feature do
  let!(:test_user) { create(:user, email: "testuser@example.com", password: "password") }

  
  scenario "User signs up with valid information" do
      visit new_user_registration_path
      fill_in "user_email", with: "test@example.com"
      fill_in "user_password", with: "password123"
      fill_in "user_password_confirmation", with: "password123"

      click_button "Sign Up"
    expect(page).to have_text("Welcome! You have signed up successfully.")
  end

  scenario "User signs up with invalid information" do
    visit new_user_registration_path
    fill_in "user_password", with: "password123"
    fill_in "user_password_confirmation", with: "password123"
    expect(page).to have_button("Sign Up", disabled: false)
    click_button "Sign Up"

    expect(page).to have_text("Email can't be blank")


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

  scenario "User updates profile with valid information" do
    sign_in test_user
    visit edit_user_registration_path
    fill_in "user_email", with: "new_email@example.com"
    fill_in "user_current_password", with: test_user.password
    click_button "Update"
    expect(page).to have_text("Your account has been updated successfully.")
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
