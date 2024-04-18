class AwardAssignmentJob < ApplicationJob
  queue_as :default

  def perform(account_id, award_id)
    account = Account.find_by(id: account_id)
    award = Award.find_by(id: award_id)

    account_award = AccountAward.find_or_create_by(account: account, award: award)

    account_award.save
  end
end