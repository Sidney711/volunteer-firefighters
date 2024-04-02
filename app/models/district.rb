class District < ApplicationRecord
  belongs_to :region

  validates :name, presence: true, length: { maximum: 100 }
  validates :code, presence: true, length: { maximum: 50 }, uniqueness: true
end