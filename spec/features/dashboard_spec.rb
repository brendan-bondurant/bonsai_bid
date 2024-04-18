require 'rails_helper'

RSpec.feature 'Dashboard - User Items and Watchlist', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:listed_item) { FactoryBot.create(:item, seller: user) }
  let(:other_item) { FactoryBot.create(:item, seller: other_user) }

  before do
    login_as(user, scope: :user)

    visit item_path(other_item)
    click_link 'Watch this Item'
  end

  scenario 'User views listed and watched items on dashboard' do
    visit dashboard_user_path(user)

    expect(page).to have_content(listed_item.name)
    
    expect(page).to have_content(other_item.name)
  end
end
