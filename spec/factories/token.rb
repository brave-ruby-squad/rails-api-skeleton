FactoryBot.define do
  factory :token do
    key        { Faker::Bitcoin.address }
    key_type   :auth
    expired_at { Faker::Date.forward(30) }

    user

    trait :verification do
      key_type :verification
    end
  end
end
