require 'rails_helper'

RSpec.describe "districts/edit", type: :view do
  let(:district) {
    District.create!(
      name: "MyString",
      code: "MyString",
      region: nil
    )
  }

  before(:each) do
    assign(:district, district)
  end

  it "renders the edit district form" do
    render

    assert_select "form[action=?][method=?]", district_path(district), "post" do

      assert_select "input[name=?]", "district[name]"

      assert_select "input[name=?]", "district[code]"

      assert_select "input[name=?]", "district[region_id]"
    end
  end
end
