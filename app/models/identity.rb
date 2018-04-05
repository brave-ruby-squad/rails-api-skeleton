class Identity < ApplicationRecord
  belongs_to :user, inverse_of: :identities

  validates :uid,      presence: true
  validates :provider, presence: true
end
