require 'rails_helper'

RSpec.describe "feedbacks/index", type: :view do
  before(:each) do
    assign(:feedbacks, [
      Feedback.create!(
        item: nil,
        from_user: nil,
        to_user: nil,
        rating: 2,
        comment: "MyText"
      ),
      Feedback.create!(
        item: nil,
        from_user: nil,
        to_user: nil,
        rating: 2,
        comment: "MyText"
      )
    ])
  end

  it "renders a list of feedbacks" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
