require 'rails_helper'

RSpec.describe "awards/new", type: :view do
  before(:each) do
    assign(:award, Award.new(
      name: "MyString",
      award_type: "MyString",
      image: "MyString",
      dependent_award_id: 1,
      minimum_service_years: 1,
      minimum_age: 1
    ))
  end

  it "renders new award form" do
    render

    assert_select "form[action=?][method=?]", awards_path, "post" do

      assert_select "input[name=?]", "award[name]"

      assert_select "input[name=?]", "award[award_type]"

      assert_select "input[name=?]", "award[image]"

      assert_select "input[name=?]", "award[dependent_award_id]"

      assert_select "input[name=?]", "award[minimum_service_years]"

      assert_select "input[name=?]", "award[minimum_age]"
    end
  end
end
