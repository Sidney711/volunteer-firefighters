require 'rails_helper'

RSpec.describe "regions/index", type: :view do
  before(:each) do
    assign(:regions, [
      Region.create!(
        name: "Name",
        code: "Code"
      ),
      Region.create!(
        name: "Name",
        code: "Code"
      )
    ])
  end

  it "renders a list of regions" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Code".to_s), count: 2
  end
end
