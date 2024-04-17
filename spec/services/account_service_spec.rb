require 'rails_helper'

RSpec.describe AccountService do
  describe '#call' do
    let(:account) { instance_double('Account') }
    let(:rodauth) { double('Rodauth') }
    let(:account_params) { { is_super_admin: false } }
    let(:account_awards_params) { { account_awards_attributes: {} } }
    let(:service) { AccountService.new(account: account, account_params: account_params, account_awards_params: account_awards_params, rodauth: rodauth) }

    before do
      allow(account).to receive(:update).and_return(true)
      allow(rodauth).to receive_message_chain(:rails_account, :is_super_admin).and_return(false)
    end

    context 'when the user is not a super admin and tries to set is_super_admin' do
      before { account_params[:is_super_admin] = true }

      it 'does not update the account and returns false' do
        expect(account).not_to receive(:update)
        expect(service.call).to eq(false)
      end
    end

    context 'when the account update is successful' do
      it 'updates the account and returns true' do
        expect(account).to receive(:update).with(account_params).and_return(true)
        expect(service.call).to eq(true)
      end

      context 'and there are award attributes provided' do
        let(:account_awards_params) do
          {
            account_awards_attributes: {
              '0' => { award_id: 1, _destroy: '1', id: 123 },
              '1' => { award_id: 2, scheduled_at: '2024-01-01T00:00:00Z' }
            }
          }
        end

        it 'processes award updates and destructions' do
          allow(account).to receive(:account_awards).and_return(double(find_by: double('AccountAward', destroy: true)))
          expect(AwardAssignmentJob).to receive(:set).with(wait_until: DateTime.parse('2024-01-01T00:00:00Z')).and_return(double('Job', perform_later: true))
          service.call
        end
      end
    end

    context 'when the account update fails' do
      it 'returns false' do
        allow(account).to receive(:update).with(account_params).and_return(false)
        expect(service.call).to eq(false)
      end
    end
  end
end
