require 'rails_helper'

RSpec.describe "bids/show", type: :view do
  before(:each) do
    assign(:bid, Bid.create!(
      item: nil,
      bidder: nil,
      bid_amount: 2.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2.5/)
  end
end
