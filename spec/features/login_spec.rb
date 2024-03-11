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
    expect(current_path).to eq(new_user_session_path)
  end
  
  scenario "User can log in from the root page with valid credentials" do
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')

    expect(current_path).to eq(root_path) 
  end

  scenario "User cannot log in from the root page with invalid credentials" do
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password')
    # send to user sign in page
    expect(current_path).to eq(new_user_session_path)
  end

  scenario "User can log in from the root page with valid credentials" do
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
  
    expect(current_path).to eq(root_path)
  end

  scenario "User cannot log in from the root page with invalid credentials" do
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password')
    # Send to user sign in page
    expect(current_path).to eq(new_user_session_path)
  end
end
