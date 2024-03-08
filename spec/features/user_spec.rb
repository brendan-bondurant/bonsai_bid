require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let!(:test_user) { create(:user, id: 1000, email: "testuser@example.com", password: "password", phone: "1234567890", address: "123 main street", name: "user") }

  
  scenario "User signs up with valid information" do
    visit new_user_registration_path
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
    visit new_user_registration_path
    fill_in "user_password", with: "password123"
    fill_in "user_password_confirmation", with: "password123"
    fill_in "user_name", with: ""
    fill_in "user_phone", with: "123"
    expect(page).to have_button("Sign Up", disabled: false)
    click_button "Sign Up"

    expect(page).to have_text("Name can't be blank")
    expect(page).to have_text("Email can't be blank")
    expect(page).to have_text("Phone must be a 10 digit number")

  end

  scenario "User logs in with valid credentials" do
    user = create(:user, email: "test@example.com", password: "password", phone: "1234567890", address: "123 main street", name: "user")

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
    save_and_open_page
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

  scenario "User updates phone number and address with valid information" do
    sign_in test_user
    visit edit_user_path(test_user)

    fill_in "Phone", with: "1234567890"
    fill_in "Address", with: "123 Main Street"

    click_button "Update User"

    expect(page).to have_text("User was successfully updated.")
    expect(user.reload.phone).to eq("1234567890")
    expect(user.reload.address).to eq("123 Main Street")
  end

  scenario "User updates phone number and address with invalid information" do
    sign_in test_user
    visit edit_user_path(test_user)

    fill_in "Phone", with: "" # Invalid phone number
    fill_in "Address", with: "" # Invalid address

    click_button "Update User"

    expect(page).to have_text("2 errors prohibited this user from being saved:")
    expect(page).to have_text("Phone can't be blank")
    expect(page).to have_text("Address can't be blank")
  end
end
