class District < ApplicationRecord
  belongs_to :region
  has_many :fire_departments, dependent: :restrict_with_exception

  validates :name, presence: true, length: { maximum: 100 }
  validates :code, presence: true, length: { maximum: 50 }, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end