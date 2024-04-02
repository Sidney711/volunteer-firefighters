class Account < ApplicationRecord
  include Rodauth::Model(RodauthMain)

  has_many :account_awards
  has_many :awards, through: :account_awards

  enum :status, unverified: 1, verified: 2, closed: 3

  validates :full_name, presence: true, length: { maximum: 100 }
  validates :birth_date, presence: true, timeliness: { type: :date }
  validates :permament_address, length: { maximum: 255 }, allow_nil: true
  validates :phone, presence: true, length: { maximum: 20 }, format: { with: /\A\+?\d+\z/ }
  validates :member_code, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :role, length: { maximum: 100 }, allow_nil: true
end