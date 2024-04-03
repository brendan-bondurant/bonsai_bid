Given(/^a user exists with email "([^"]*)" and password "([^"]*)"$/) do |email, password|
  FactoryBot.create(:user, email: email, password: password)
end

When(/^I visit the (home|login) page$/) do |page|
  visit page == 'home' ? root_path : new_user_session_path
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

When(/^I click the "([^"]*)" button$/) do |button|
  click_button button
end

Then(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^I should be on the (home|login) page$/) do |page|
  expected_path = page == 'home' ? root_path : new_user_session_path
  expect(current_path).to eq(expected_path)
end
