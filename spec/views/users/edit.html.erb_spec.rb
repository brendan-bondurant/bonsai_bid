require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  let(:user) {
    User.create!(
      email: "MyString",
      password_digest: "MyString",
      name: "MyString",
      address: "MyText",
      phone: "MyString"
    )
  }

  before(:each) do
    assign(:user, user)
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(user), "post" do

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[password_digest]"

      assert_select "input[name=?]", "user[name]"

      assert_select "textarea[name=?]", "user[address]"

      assert_select "input[name=?]", "user[phone]"
    end
  end
end
