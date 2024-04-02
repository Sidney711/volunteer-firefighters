class AccountAward < ApplicationRecord
  belongs_to :account
  belongs_to :award
end