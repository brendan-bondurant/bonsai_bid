require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "User signs up with valid information" do
    visit new_user_path
    
    fill_in "user_email", with: "test@example.com"
    fill_in "user_password", with: "password123"
    fill_in "user_password_confirmation", with: "password123"
    fill_in "user_name", with: "Test User"
    fill_in "user_phone", with: "1234567890"
    fill_in "user_address", with: "123 main street"
    click_button "Sign Up"
    expect(page).to have_text("Welcome! You have signed up successfully.")
  end

  scenario "User signs up with invalid information" do
    visit new_user_path
    fill_in "user_password", with: "password123"
    fill_in "user_password_confirmation", with: "password123"
    fill_in "user_name", with: ""
    fill_in "user_phone", with: "123"
    expect(page).to have_button("Sign Up", disabled: false)
    click_button "Sign Up"
    expect(page).to have_text("Email is invalid")
    expect(page).to have_text("Name can't be blank")
    expect(page).to have_text("Email can't be blank")
    expect(page).to have_text("Phone must be a 10 digit number")

  end

  scenario "User logs in with valid credentials" do
    user = create(:user, email: "test@example.com", password: "password", phone: "1234567890", address: "123 main street", name: "user")

    visit login_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "password"
    click_button "Log in"

    expect(page).to have_text("Signed in successfully.")
  end

  scenario "User logs in with invalid credentials" do
    visit login_path
    fill_in "user_email", with: "nonexistent@example.com"
    fill_in "user_password", with: "invalidpassword"
    click_button "Log in"

    expect(page).to have_text("Sorry, we are unable to find a user with this e-mail. Please check credentials or create an account.")
  end

  # scenario "User updates profile with valid information" do
  #   user = create(:user)

  #   sign_in user
  #   visit edit_user_registration_path
  #   fill_in "user_mail", with: "new_email@example.com"
  #   fill_in "Current password", with: user.password
  #   click_button "Update"

  #   expect(page).to have_text("Your account has been updated successfully.")
  # end

  # scenario "User updates profile with invalid information" do
  #   user = create(:user)

  #   sign_in user
  #   visit edit_user_registration_path
  #   fill_in "Email", with: "invalid_email"
  #   fill_in "Current password", with: user.password
  #   click_button "Update"

  #   expect(page).to have_text("Please review the problems below:")
  #   expect(page).to have_text("Email is invalid")
  # end

  # scenario "User deletes account" do
  #   user = create(:user)

  #   sign_in user
  #   visit edit_user_registration_path
  #   click_button "Cancel my account"

  #   expect(page).to have_text("Bye! Your account has been successfully cancelled. We hope to see you again soon.")
  # end
end
