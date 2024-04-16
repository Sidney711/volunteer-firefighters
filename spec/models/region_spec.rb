# spec/models/region_spec.rb
require 'rails_helper'

RSpec.describe Region, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_presence_of(:code) }
    it { should validate_length_of(:code).is_at_most(50) }
    it { should validate_uniqueness_of(:code) }
  end

  describe "associations" do
    it { should have_many(:districts).dependent(:restrict_with_exception) }
  end

  describe "factory" do
    it "is valid" do
      region = FactoryBot.build(:region)
      expect(region).to be_valid
    end
  end
end
