require 'rails_helper'

RSpec.describe "memberships/edit", type: :view do
  let(:membership) {
    Membership.create!(
      fire_department: nil,
      account: nil,
      role: 1,
      status: 1
    )
  }

  before(:each) do
    assign(:membership, membership)
  end

  it "renders the edit membership form" do
    render

    assert_select "form[action=?][method=?]", membership_path(membership), "post" do

      assert_select "input[name=?]", "membership[fire_department_id]"

      assert_select "input[name=?]", "membership[account_id]"

      assert_select "input[name=?]", "membership[role]"

      assert_select "input[name=?]", "membership[status]"
    end
  end
end
