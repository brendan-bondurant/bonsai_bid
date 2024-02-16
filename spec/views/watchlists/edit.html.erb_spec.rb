require 'rails_helper'

RSpec.describe "watchlists/edit", type: :view do
  let(:watchlist) {
    Watchlist.create!(
      user: nil,
      item: nil
    )
  }

  before(:each) do
    assign(:watchlist, watchlist)
  end

  it "renders the edit watchlist form" do
    render

    assert_select "form[action=?][method=?]", watchlist_path(watchlist), "post" do

      assert_select "input[name=?]", "watchlist[user_id]"

      assert_select "input[name=?]", "watchlist[item_id]"
    end
  end
end
