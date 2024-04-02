require 'rails_helper'

RSpec.describe "awards/index", type: :view do
  before(:each) do
    assign(:awards, [
      Award.create!(
        name: "Name",
        award_type: "Award Type",
        image: "Image",
        dependent_award_id: 2,
        minimum_service_years: 3,
        minimum_age: 4
      ),
      Award.create!(
        name: "Name",
        award_type: "Award Type",
        image: "Image",
        dependent_award_id: 2,
        minimum_service_years: 3,
        minimum_age: 4
      )
    ])
  end

  it "renders a list of awards" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Award Type".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Image".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
  end
end
