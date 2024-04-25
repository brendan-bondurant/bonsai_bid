require 'rails_helper'

RSpec.feature "Item Search Handling", type: :feature do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit root_path
  end

  scenario "User searches for an item that does not exist" do
    fill_in 'search', with: 'nonexistentitem'
    click_button 'Search'
    
    expect(page).to have_content('No results found')
  end
end
