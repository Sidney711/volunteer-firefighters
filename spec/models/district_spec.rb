# spec/models/district_spec.rb
require 'rails_helper'

RSpec.describe District, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_presence_of(:code) }
    it { should validate_length_of(:code).is_at_most(50) }
    it { should validate_uniqueness_of(:code) }
  end

  describe "associations" do
    it { should belong_to(:region) }
    it { should have_many(:fire_departments).dependent(:restrict_with_exception) }
  end

  describe "factory" do
    it "is valid" do
      district = FactoryBot.build(:district)
      expect(district).to be_valid
    end
  end
end
