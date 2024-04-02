require 'rails_helper'

RSpec.describe "awards/show", type: :view do
  before(:each) do
    assign(:award, Award.create!(
      name: "Name",
      award_type: 2,
      image: "Image",
      dependent_award_id: 3,
      minimum_service_years: 4,
      minimum_age: 5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
  end
end
