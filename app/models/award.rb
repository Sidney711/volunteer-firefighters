class Award < ApplicationRecord
  has_many :account_awards, dependent: :restrict_with_exception
  has_many :accounts, through: :account_awards
  has_one_attached :image

  enum award_type: { recognition: 1, medal: 2, order_award: 3 }

  validates :name, presence: true, length: { maximum: 255 }
  validates :award_type, presence: true, inclusion: { in: award_types.keys }
  validates :minimum_service_years, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :minimum_age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :dependent_award_id, allow_nil: true, numericality: { only_integer: true }
  validate :validate_dependent_award_exists, if: -> { dependent_award_id.present? }

  def self.ransackable_attributes(auth_object = nil)
    ["award_type", "created_at", "dependent_award_id", "id", "id_value", "minimum_age", "minimum_service_years", "name", "updated_at"]
  end


  def dependent_award
    Award.find_by(id: dependent_award_id)
  end

  def get_info
    "#{name}, #{award_type}, Minimum years in SDH: #{minimum_service_years}, Minimum age: #{minimum_age}, Dependent award: #{get_dependent_award_name}"
  end

  def get_dependent_award_name
    if dependent_award_id.present?
      dependent_award.name
    else
      '-'
    end
  end

  def validate_dependent_award_exists
    unless Award.exists?(dependent_award_id)
      errors.add(:dependent_award_id, 'does not exist')
    end
  end
end