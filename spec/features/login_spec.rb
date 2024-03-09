require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do
  let!(:user) { FactoryBot.create(:user, email: 'user@example.com', password: 'password') }

  scenario "User logs in successfully" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: 'password'
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
  end

  scenario "User fails to log in with wrong credentials" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: 'wrongpassword'
    click_button "Log in"

    expect(page).to have_content("Invalid Email or password.")
    # Ensure the user remains on the login page
    expect(current_path).to eq(new_user_session_path)
  end
  scenario "User can log in from the root page with valid credentials" do
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    # Verify the user is redirected to the appropriate page after login
    # This might be root_path or another path depending on your app's configuration
    expect(current_path).to eq(root_path) # Adjust this as necessary
  end

  scenario "User cannot log in from the root page with invalid credentials" do
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password')
    # Verify the user stays on the root page with the login form still displayed
    expect(current_path).to eq(root_path)
  end
  scenario "User can log in from the root page with valid credentials" do
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    # Verify the user is redirected to the appropriate page after login
    # This might be root_path or another path depending on your app's configuration
    expect(current_path).to eq(root_path) # Adjust this as necessary
  end

  scenario "User cannot log in from the root page with invalid credentials" do
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password')
    # Verify the user stays on the root page with the login form still displayed
    expect(current_path).to eq(root_path)
  end
end
