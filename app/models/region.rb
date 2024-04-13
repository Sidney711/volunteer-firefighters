class Region < ApplicationRecord
  has_many :districts, dependent: :restrict_with_exception

  validates :name, presence: true, length: { maximum: 100 }
  validates :code, presence: true, length: { maximum: 50 }, uniqueness: true
end