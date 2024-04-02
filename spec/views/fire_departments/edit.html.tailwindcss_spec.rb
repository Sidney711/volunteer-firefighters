require 'rails_helper'

RSpec.describe "fire_departments/edit", type: :view do
  let(:fire_department) {
    FireDepartment.create!(
      name: "MyString",
      code: "MyString",
      district: nil,
      address: "MyString"
    )
  }

  before(:each) do
    assign(:fire_department, fire_department)
  end

  it "renders the edit fire_department form" do
    render

    assert_select "form[action=?][method=?]", fire_department_path(fire_department), "post" do

      assert_select "input[name=?]", "fire_department[name]"

      assert_select "input[name=?]", "fire_department[code]"

      assert_select "input[name=?]", "fire_department[district_id]"

      assert_select "input[name=?]", "fire_department[address]"
    end
  end
end
