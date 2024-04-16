require 'rails_helper'

RSpec.describe Membership, type: :model do
  describe 'associations' do
    it { should belong_to(:fire_department) }
    it { should belong_to(:account) }
  end

  describe 'validations' do
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:status) }

    context 'custom validations' do
      let(:account) { create(:account) }
      let!(:existing_membership) { create(:membership, account: account, status: 'active') }

      it 'does not allow more than one active membership per account' do
        new_membership = build(:membership, account: account, status: 'active')
        new_membership.valid?
        expect(new_membership.errors[:base]).to include('A member can only have one active membership.')
      end
    end
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:role).with_values(member: 0, administrator: 1) }
    it { is_expected.to define_enum_for(:status).with_values(active: 0, archived: 1) }
  end
end
