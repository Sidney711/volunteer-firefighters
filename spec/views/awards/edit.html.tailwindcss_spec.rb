require 'rails_helper'

RSpec.describe "awards/edit", type: :view do
  let(:award) {
    Award.create!(
      name: "MyString",
      award_type: 1,
      image: "MyString",
      dependent_award_id: 1,
      minimum_service_years: 1,
      minimum_age: 1
    )
  }

  before(:each) do
    assign(:award, award)
  end

  it "renders the edit award form" do
    render

    assert_select "form[action=?][method=?]", award_path(award), "post" do

      assert_select "input[name=?]", "award[name]"

      assert_select "input[name=?]", "award[award_type]"

      assert_select "input[name=?]", "award[image]"

      assert_select "input[name=?]", "award[dependent_award_id]"

      assert_select "input[name=?]", "award[minimum_service_years]"

      assert_select "input[name=?]", "award[minimum_age]"
    end
  end
end
