require 'rails_helper'

RSpec.describe "bids/new", type: :view do
  before(:each) do
    assign(:bid, Bid.new(
      item: nil,
      bidder: nil,
      bid_amount: 1.5
    ))
  end

  it "renders new bid form" do
    render

    assert_select "form[action=?][method=?]", bids_path, "post" do

      assert_select "input[name=?]", "bid[item_id]"

      assert_select "input[name=?]", "bid[bidder_id]"

      assert_select "input[name=?]", "bid[bid_amount]"
    end
  end
end
