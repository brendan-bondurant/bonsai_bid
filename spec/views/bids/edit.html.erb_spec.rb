require 'rails_helper'

RSpec.describe "bids/edit", type: :view do
  let(:bid) {
    Bid.create!(
      item: nil,
      bidder: nil,
      bid_amount: 1.5
    )
  }

  before(:each) do
    assign(:bid, bid)
  end

  it "renders the edit bid form" do
    render

    assert_select "form[action=?][method=?]", bid_path(bid), "post" do

      assert_select "input[name=?]", "bid[item_id]"

      assert_select "input[name=?]", "bid[bidder_id]"

      assert_select "input[name=?]", "bid[bid_amount]"
    end
  end
end
