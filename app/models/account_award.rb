class AccountAward < ApplicationRecord
  belongs_to :account
  belongs_to :award

  validate :check_minimum_age, :check_membership_duration, :check_dependent_award

  private

  def check_minimum_age
    return if award.minimum_age.zero?
    if account.age < award.minimum_age
      errors.add(:base, "User is too young to receive this award.")
    end
  end

  def check_membership_duration
    return if award.minimum_service_years.zero?
    if account.membership_duration_years < award.minimum_service_years
      errors.add(:base, "User does not meet the minimum service duration required for this award.")
    end
  end

  def check_dependent_award
    return unless award.dependent_award
    unless account.awards.exists?(award.dependent_award.id)
      errors.add(:base, "User does not have the required dependent award.")
    end
  end
end