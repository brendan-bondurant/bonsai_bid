require 'rails_helper'

RSpec.describe "items/new", type: :view do
  before(:each) do
    assign(:item, Item.new(
      seller: nil,
      category: nil,
      name: "MyString",
      description: "MyText",
      images: "MyText",
      starting_price: 1.5,
      current_price: 1.5,
      buy_it_now_price: 1.5,
      status: "MyString"
    ))
  end

  it "renders new item form" do
    render

    assert_select "form[action=?][method=?]", items_path, "post" do

      assert_select "input[name=?]", "item[seller_id]"

      assert_select "input[name=?]", "item[category_id]"

      assert_select "input[name=?]", "item[name]"

      assert_select "textarea[name=?]", "item[description]"

      assert_select "textarea[name=?]", "item[images]"

      assert_select "input[name=?]", "item[starting_price]"

      assert_select "input[name=?]", "item[current_price]"

      assert_select "input[name=?]", "item[buy_it_now_price]"

      assert_select "input[name=?]", "item[status]"
    end
  end
end
