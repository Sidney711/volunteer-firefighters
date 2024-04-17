require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'associations' do
    it { should have_many(:account_awards).dependent(:destroy) }
    it { should have_many(:awards).through(:account_awards) }
    it { should have_many(:memberships).dependent(:destroy) }
    it { should have_many(:fire_departments).through(:memberships) }
  end

  describe 'validations' do
    it { should validate_presence_of(:full_name) }
    it { should validate_length_of(:full_name).is_at_most(100) }
    it { should validate_presence_of(:birth_date) }
    it { should validate_length_of(:permament_address).is_at_most(255).allow_nil }
    it { should validate_presence_of(:phone) }
    it { should validate_length_of(:phone).is_at_most(20) }
    it { should validate_presence_of(:member_code) }
    it { should validate_length_of(:member_code).is_at_most(50) }
    it { should validate_uniqueness_of(:member_code) }
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values(unverified: 1, verified: 2, closed: 3) }
  end
end