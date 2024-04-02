require 'rails_helper'

RSpec.describe "fire_departments/show", type: :view do
  before(:each) do
    assign(:fire_department, FireDepartment.create!(
      name: "Name",
      code: "Code",
      district: nil,
      address: "Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Code/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Address/)
  end
end
