require 'rails_helper'

RSpec.describe "feedbacks/new", type: :view do
  before(:each) do
    assign(:feedback, Feedback.new(
      item: nil,
      from_user: nil,
      to_user: nil,
      rating: 1,
      comment: "MyText"
    ))
  end

  it "renders new feedback form" do
    render

    assert_select "form[action=?][method=?]", feedbacks_path, "post" do

      assert_select "input[name=?]", "feedback[item_id]"

      assert_select "input[name=?]", "feedback[from_user_id]"

      assert_select "input[name=?]", "feedback[to_user_id]"

      assert_select "input[name=?]", "feedback[rating]"

      assert_select "textarea[name=?]", "feedback[comment]"
    end
  end
end
