require 'rails_helper'

RSpec.describe "fire_departments/new", type: :view do
  before(:each) do
    assign(:fire_department, FireDepartment.new(
      name: "MyString",
      code: "MyString",
      district: nil,
      address: "MyString"
    ))
  end

  it "renders new fire_department form" do
    render

    assert_select "form[action=?][method=?]", fire_departments_path, "post" do

      assert_select "input[name=?]", "fire_department[name]"

      assert_select "input[name=?]", "fire_department[code]"

      assert_select "input[name=?]", "fire_department[district_id]"

      assert_select "input[name=?]", "fire_department[address]"
    end
  end
end
