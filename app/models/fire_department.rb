class FireDepartment < ApplicationRecord
  belongs_to :district
  has_many :memberships

  validates :name, presence: true, length: { maximum: 255 }
  validates :code, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :address, presence: true, length: { maximum: 255 }
end
