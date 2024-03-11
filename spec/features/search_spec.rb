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
  
  it 'allows users to search for items and click on them' do
    user_with_items
    visit root_path
    fill_in 'search', with: 'bush'
    click_button 'Search'
    
    expect(page).to have_content(@item1.name)
    click_link("#{@item1.name}")
    category = Category.find(@item1.category_id)
    expect(page).to have_content("#{@item1.name}")
    expect(page).to have_content("#{@item1.description}")
    expect(page).to have_content("#{@item1.starting_price}")
    expect(page).to have_content("#{@item1.current_price}")
    expect(page).to have_content("#{category.name}")
    expect(page).to have_content("#{@item1.buy_it_now_price}")
    expect(page).to have_content("#{@item1.start_date}")
    expect(page).to have_content("#{@item1.end_date}")
    expect(page).to have_content("#{@item1.seller.id}")
  end
end