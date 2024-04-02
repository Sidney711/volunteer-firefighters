require 'rails_helper'

RSpec.describe "memberships/new", type: :view do
  before(:each) do
    assign(:membership, Membership.new(
      fire_department: nil,
      member: nil,
      role: "MyString",
      status: "MyString"
    ))
  end

  it "renders new membership form" do
    render

    assert_select "form[action=?][method=?]", memberships_path, "post" do

      assert_select "input[name=?]", "membership[fire_department_id]"

      assert_select "input[name=?]", "membership[member_id]"

      assert_select "input[name=?]", "membership[role]"

      assert_select "input[name=?]", "membership[status]"
    end
  end
end
