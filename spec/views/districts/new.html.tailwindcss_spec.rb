require 'rails_helper'

RSpec.describe "districts/new", type: :view do
  before(:each) do
    assign(:district, District.new(
      name: "MyString",
      code: "MyString",
      region: nil
    ))
  end

  it "renders new district form" do
    render

    assert_select "form[action=?][method=?]", districts_path, "post" do

      assert_select "input[name=?]", "district[name]"

      assert_select "input[name=?]", "district[code]"

      assert_select "input[name=?]", "district[region_id]"
    end
  end
end
