class Identity < ApplicationRecord
  belongs_to :user, inverse_of: :identities

  validates :uid,      presence: true, uniqueness: { scope: %i[provider] }
  validates :provider, presence: true
end
