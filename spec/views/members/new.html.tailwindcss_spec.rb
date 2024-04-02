require 'rails_helper'

RSpec.describe "members/new", type: :view do
  before(:each) do
    assign(:member, Member.new(
      full_name: "MyString",
      permanent_address: "MyString",
      email: "MyString",
      phone: "MyString",
      member_code: "MyString",
      role: "MyString"
    ))
  end

  it "renders new member form" do
    render

    assert_select "form[action=?][method=?]", members_path, "post" do

      assert_select "input[name=?]", "member[full_name]"

      assert_select "input[name=?]", "member[permanent_address]"

      assert_select "input[name=?]", "member[email]"

      assert_select "input[name=?]", "member[phone]"

      assert_select "input[name=?]", "member[member_code]"

      assert_select "input[name=?]", "member[role]"
    end
  end
end
