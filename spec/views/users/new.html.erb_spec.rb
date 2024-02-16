require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      email: "MyString",
      password_digest: "MyString",
      name: "MyString",
      address: "MyText",
      phone: "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[password_digest]"

      assert_select "input[name=?]", "user[name]"

      assert_select "textarea[name=?]", "user[address]"

      assert_select "input[name=?]", "user[phone]"
    end
  end
end
