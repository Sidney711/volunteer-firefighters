class Membership < ApplicationRecord
  belongs_to :fire_department
  belongs_to :member
end
