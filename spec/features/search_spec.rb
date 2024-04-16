require 'rails_helper'

RSpec.describe 'Item search', type: :feature do
  it 'allows users to search for items by keyword, one result' do
    user_with_items
    visit root_path
    fill_in 'search', with: 'bush'
    click_button 'Search'
    
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item1.description)
    expect(page).to_not have_content(@item3.name)
    expect(page).to_not have_content(@item3.description)
  end

  it 'allows users to search for items by keyword, two results' do
    user_with_items
    visit root_path
    fill_in 'search', with: 'bonsai'
    click_button 'Search'
    
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item1.description)
    expect(page).to have_content(@item3.name)
    expect(page).to have_content(@item3.description)
  end

  it 'allows users to search for items by keyword, no results' do
    user_with_items
    visit root_path
    fill_in 'search', with: 'nothing'
    click_button 'Search'
    
    expect(page).to have_content('No results found')
  end
end