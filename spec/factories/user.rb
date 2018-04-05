FactoryBot.define do
  factory :user do
    name                  { Faker::Name.name }
    email                 { Faker::Internet.email }
    password              { SecureRandom.base64(6) }
    password_confirmation { password }
  end
end
