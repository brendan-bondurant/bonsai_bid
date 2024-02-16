require 'rails_helper'

RSpec.describe "feedbacks/edit", type: :view do
  let(:feedback) {
    Feedback.create!(
      item: nil,
      from_user: nil,
      to_user: nil,
      rating: 1,
      comment: "MyText"
    )
  }

  before(:each) do
    assign(:feedback, feedback)
  end

  it "renders the edit feedback form" do
    render

    assert_select "form[action=?][method=?]", feedback_path(feedback), "post" do

      assert_select "input[name=?]", "feedback[item_id]"

      assert_select "input[name=?]", "feedback[from_user_id]"

      assert_select "input[name=?]", "feedback[to_user_id]"

      assert_select "input[name=?]", "feedback[rating]"

      assert_select "textarea[name=?]", "feedback[comment]"
    end
  end
end
