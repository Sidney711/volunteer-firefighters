require 'rails_helper'

RSpec.describe "memberships/index", type: :view do
  before(:each) do
    assign(:memberships, [
      Membership.create!(
        fire_department: nil,
        account: nil,
        role: 2,
        status: 3
      ),
      Membership.create!(
        fire_department: nil,
        account: nil,
        role: 2,
        status: 3
      )
    ])
  end

  it "renders a list of memberships" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
  end
end
