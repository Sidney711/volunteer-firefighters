require 'rails_helper'

RSpec.describe "members/edit", type: :view do
  let(:member) {
    Member.create!(
      full_name: "MyString",
      permanent_address: "MyString",
      email: "MyString",
      phone: "MyString",
      member_code: "MyString",
      role: "MyString"
    )
  }

  before(:each) do
    assign(:member, member)
  end

  it "renders the edit member form" do
    render

    assert_select "form[action=?][method=?]", member_path(member), "post" do

      assert_select "input[name=?]", "member[full_name]"

      assert_select "input[name=?]", "member[permanent_address]"

      assert_select "input[name=?]", "member[email]"

      assert_select "input[name=?]", "member[phone]"

      assert_select "input[name=?]", "member[member_code]"

      assert_select "input[name=?]", "member[role]"
    end
  end
end
