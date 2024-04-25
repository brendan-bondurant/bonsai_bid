RSpec.feature "Unauthorized Access Handling", type: :feature do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:item) { create(:item, seller: other_user) }

  before do
    sign_in user
  end

  scenario "User attempts to edit another user's item" do
    visit edit_item_path(item)

    expect(page).to have_text("You are not authorized to perform this action.")
    expect(page).to have_current_path(root_path)
  end
end
