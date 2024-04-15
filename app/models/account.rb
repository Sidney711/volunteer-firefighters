class Account < ApplicationRecord
  include Rodauth::Model(RodauthMain)

  has_many :account_awards, dependent: :destroy
  has_many :awards, through: :account_awards
  has_many :memberships, dependent: :destroy
  has_many :fire_departments, through: :memberships

  accepts_nested_attributes_for :account_awards, reject_if: :all_blank, allow_destroy: true

  enum :status, unverified: 1, verified: 2, closed: 3

  validates :full_name, presence: true, length: { maximum: 100 }
  validates :birth_date, presence: true, timeliness: { type: :date }
  validates :permament_address, length: { maximum: 255 }, allow_nil: true
  validates :phone, presence: true, length: { maximum: 20 }
  validates :member_code, presence: true, length: { maximum: 50 }, uniqueness: true

  def full_info
    "#{full_name}, #{birth_date}, #{member_code}"
  end

  def is_admin
    if Membership.where(account_id: self.id, role: 1).count > 0
      true
    else
      false
    end
  end

  def age
    ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
  end

  def oldest_membership_date
    memberships.minimum(:start_date)
  end

  def membership_duration_years
    return 0 unless oldest_membership_date
    ((Time.zone.now - oldest_membership_date.to_time) / 1.year.seconds).floor
  end
end