require 'rails_helper'

RSpec.describe "memberships/show", type: :view do
  before(:each) do
    assign(:membership, Membership.create!(
      fire_department: nil,
      member: nil,
      role: "Role",
      status: "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Role/)
    expect(rendered).to match(/Status/)
  end
end
