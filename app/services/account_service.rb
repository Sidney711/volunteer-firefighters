
class AccountService
  def initialize(account:, account_params:, account_awards_params:, rodauth:)
    @account = account
    @account_params = account_params
    @account_awards_params = account_awards_params
    @rodauth = rodauth
  end

  def call
    return false if !@rodauth.rails_account.is_super_admin && @account_params[:is_super_admin]

    if @account.update(@account_params)
      update_account_awards
      true
    else
      false
    end
  end

  private

  def update_account_awards
    unless @account_awards_params[:account_awards_attributes].nil?
      @account_awards_params[:account_awards_attributes].each do |_, attributes|
        award_id = attributes[:award_id]
        scheduled_at = attributes[:scheduled_at]
        if attributes[:_destroy] == "1"
          account_award = @account.account_awards.find_by(award_id: award_id)
          account_award&.destroy
        elsif scheduled_at.present? && !attributes[:id].present?
          AwardAssignmentJob.set(wait_until: DateTime.parse(scheduled_at)).perform_later(@account, award_id)
        else
          account_award = @account.account_awards.find_by(id: attributes[:id])
          if account_award
            account_award.update(award_id: award_id, scheduled_at: nil)
          else
            @account.account_awards.create(award_id: award_id)
          end
        end
      end
    end
  end
end