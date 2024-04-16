# spec/models/award_spec.rb
require 'rails_helper'

RSpec.describe Award, type: :model do
  describe 'associations' do
    it { should have_many(:account_awards).dependent(:restrict_with_exception) }
    it { should have_many(:accounts).through(:account_awards) }
    it { should have_one_attached(:image) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(255) }
    it { should validate_presence_of(:award_type) }
    it { should define_enum_for(:award_type).with_values(recognition: 1, medal: 2, order_award: 3) }
    it { should validate_numericality_of(:minimum_service_years).is_greater_than_or_equal_to(0).only_integer }
    it { should validate_numericality_of(:minimum_age).is_greater_than_or_equal_to(0).only_integer }
    it 'validates numericality of dependent_award_id if present' do
      award = build(:award, dependent_award_id: 'not_a_number')
      expect(award).not_to be_valid
      expect(award.errors[:dependent_award_id]).to include('is not a number')
    end
    it 'allows nil for dependent_award_id' do
      expect(build(:award, dependent_award_id: nil)).to be_valid
    end
  end

  describe '#validate_dependent_award_exists' do
    let(:dependent_award) { create(:award) }
    let(:award) { build(:award, dependent_award_id: dependent_award.id) }

    it 'adds an error if dependent_award_id does not exist' do
      award.dependent_award_id = Award.last.id + 1 # non-existent ID
      award.validate_dependent_award_exists
      expect(award.errors[:dependent_award_id]).to include('does not exist')
    end

    it 'does not add an error if dependent_award_id exists' do
      expect(award).to be_valid
    end
  end

  describe 'methods' do
    let(:award) { create(:award, name: "Hero Award", award_type: :medal) }

    it '#get_info' do
      expect(award.get_info).to include("Hero Award, medal")
    end
  end
end
