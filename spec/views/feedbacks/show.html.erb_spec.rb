require 'rails_helper'

RSpec.describe "feedbacks/show", type: :view do
  before(:each) do
    assign(:feedback, Feedback.create!(
      item: nil,
      from_user: nil,
      to_user: nil,
      rating: 2,
      comment: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
