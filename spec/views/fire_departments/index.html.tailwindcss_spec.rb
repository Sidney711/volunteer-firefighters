require 'rails_helper'

RSpec.describe "fire_departments/index", type: :view do
  before(:each) do
    assign(:fire_departments, [
      FireDepartment.create!(
        name: "Name",
        code: "Code",
        district: nil,
        address: "Address"
      ),
      FireDepartment.create!(
        name: "Name",
        code: "Code",
        district: nil,
        address: "Address"
      )
    ])
  end

  it "renders a list of fire_departments" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Code".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Address".to_s), count: 2
  end
end
