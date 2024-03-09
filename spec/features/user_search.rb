require 'rails_helper'

RSpec.feature 'User finds & views items', type: :feature do
  
  scenario 'User finds items by keywords' do
    # Create sample items in the database
    FactoryBot.create(:item, name: 'Vintage Vase', description: 'A beautiful vintage vase.')
    FactoryBot.create(:item, name: 'Antique Lamp', description: 'An exquisite antique lamp.')

    # User visits the items index page
    visit items_path

    # User fills in the search form with a keyword and submits
    fill_in 'search', with: 'vase'
    click_button 'Search'

    # Expect page to display items related to the keyword and not display unrelated items
    expect(page).to have_content 'Vintage Vase'
    expect(page).not_to have_content 'Antique Lamp'
  end
  
  scenario 'User finds items with clear descriptions and details' do
    # Create sample items in the database
    item = FactoryBot.create(:item, name: 'Vintage Vase', description: 'A beautiful vintage vase from the 1920s.')

    # User visits the items index page
    visit items_path

    # Expect page to have item details
    expect(page).to have_content 'Vintage Vase'
    expect(page).to have_content 'A beautiful vintage vase from the 1920s.'
  end
end
