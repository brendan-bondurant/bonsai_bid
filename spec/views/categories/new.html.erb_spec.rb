require 'rails_helper'

RSpec.describe "categories/new", type: :view do
  before(:each) do
    assign(:category, Category.new(
      name: "MyString",
      description: "MyText",
      parent_id: ""
    ))
  end

  it "renders new category form" do
    render

    assert_select "form[action=?][method=?]", categories_path, "post" do

      assert_select "input[name=?]", "category[name]"

      assert_select "textarea[name=?]", "category[description]"

      assert_select "input[name=?]", "category[parent_id]"
    end
  end
end
