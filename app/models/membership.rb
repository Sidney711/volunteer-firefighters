class Membership < ApplicationRecord
  belongs_to :fire_department
  belongs_to :account

  enum role: { member: 0, administrator: 1 }
  enum status: { active: 0, archived: 1 }

  validates :start_date, timeliness: { type: :date }
  validates :role, presence: true, inclusion: { in: roles.keys }
  validates :status, presence: true, inclusion: { in: statuses.keys }
end
