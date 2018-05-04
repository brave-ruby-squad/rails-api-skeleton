FactoryBot.define do
  factory :token do
    key        { Faker::Bitcoin.address }
    key_type   :auth
    expired_at { Faker::Date.forward(30) }

    user

    trait :verification do
      key_type :verification
    end

    trait :restoration do
      key_type :restoration
    end
  end
end
