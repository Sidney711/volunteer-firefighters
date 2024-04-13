class Membership < ApplicationRecord
  belongs_to :fire_department
  belongs_to :account

  enum role: { member: 0, administrator: 1 }
  enum status: { active: 0, archived: 1 }

  validates :start_date, timeliness: { type: :date }
  validates :role, presence: true, inclusion: { in: roles.keys }
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validate :one_active_membership_per_user

  private

  def one_active_membership_per_user
    if new_record? || status_changed?
      if Membership.where(account_id: account_id, status: status).exists?
        errors.add(:base, 'A member can only have one active membership.')
      end
    end
  end
end