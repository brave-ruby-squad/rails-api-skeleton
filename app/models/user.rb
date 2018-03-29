class User < ApplicationRecord
  EMAIL_PATTERN = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  has_secure_password

  validates :email, format: { with: EMAIL_PATTERN }
  validates :password, confirmation: true, length: 6..20
  validates :password_confirmation, presence: true
end
