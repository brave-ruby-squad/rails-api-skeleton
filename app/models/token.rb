class Token < ApplicationRecord
  belongs_to :user, inverse_of: :tokens

  validates :key,        presence: true
  validates :key_type,   presence: true
  validates :expired_at, presence: true
end
