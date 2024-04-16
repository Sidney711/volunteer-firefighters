# spec/models/fire_department_spec.rb
require 'rails_helper'

RSpec.describe FireDepartment, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(255) }
    it { should validate_presence_of(:code) }
    it { should validate_length_of(:code).is_at_most(50) }
    it { should validate_uniqueness_of(:code) }
    it { should validate_presence_of(:address) }
    it { should validate_length_of(:address).is_at_most(255) }
  end

  describe "associations" do
    it { should belong_to(:district) }
    it { should have_many(:memberships).dependent(:restrict_with_exception) }
  end

  describe "factory" do
    it "is valid" do
      fire_department = FactoryBot.build(:fire_department)
      expect(fire_department).to be_valid
    end
  end
end
