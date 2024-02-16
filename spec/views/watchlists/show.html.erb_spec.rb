require 'rails_helper'

RSpec.describe "watchlists/show", type: :view do
  before(:each) do
    assign(:watchlist, Watchlist.create!(
      user: nil,
      item: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
