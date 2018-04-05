FactoryBot.define do
  factory :user do
    name                  { Faker::Name.name }

    password              { SecureRandom.base64(8) }
    password_confirmation { password }
  end
end
