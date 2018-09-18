class Identity < ApplicationRecord
  EMAIL_PATTERN = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  PHONE_PATTERN = /\A\d{3}-\d{3}-\d{4}\z/i

  belongs_to :user, inverse_of: :identities

  validates :uid,      presence: true, uniqueness: { scope: %i[provider] }
  validates :provider, presence: true

  validates :uid, format: { with: EMAIL_PATTERN }, if: :email?
  validates :uid, format: { with: PHONE_PATTERN }, if: :phone?

  private

  def email?
    provider == :email
  end

  def phone?
    provider == :phone
  end
end
