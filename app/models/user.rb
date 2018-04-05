class User < ApplicationRecord
  has_secure_password

  has_many :identities, inverse_of: :user
  has_many :tokens,     inverse_of: :user

  validates :password, confirmation: true, length: 6..20
  validates :password_confirmation, presence: true
end
