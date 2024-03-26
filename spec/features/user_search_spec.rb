require 'rails_helper'

RSpec.feature 'User finds & views items', type: :feature do
  let(:user) { create(:user, id: 798) }

  scenario 'User finds items by keywords' do
    FactoryBot.create(:item, id: 999, seller: user, name: 'Vintage Vase', description: 'A beautiful vintage vase.')

    visit root_path
    fill_in 'search', with: 'vase'
    click_button 'Search'

    expect(page).to have_content 'Vintage Vase'
    expect(page).not_to have_content 'Antique Lamp'
  end
  
  scenario 'User finds items with clear descriptions and details' do
    item = FactoryBot.create(:item, id: 888, seller: user, name: 'Vintage Vase', description: 'A beautiful vintage vase from the 1920s.')

    visit items_path

    expect(page).to have_content 'Vintage Vase'
    expect(page).to have_content 'A beautiful vintage vase from the 1920s.'
  end
end
