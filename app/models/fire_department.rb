class FireDepartment < ApplicationRecord
  belongs_to :district
  has_many :memberships, dependent: :restrict_with_exception

  validates :name, presence: true, length: { maximum: 255 }
  validates :code, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :address, presence: true, length: { maximum: 255 }

  def self.ransackable_attributes(auth_object = nil)
    ["address", "code", "created_at", "district_id", "id", "id_value", "name", "updated_at"]
  end
end
