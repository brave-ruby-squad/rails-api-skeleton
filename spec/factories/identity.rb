FactoryBot.define do
  factory :identity do
    trait :email do
      uid      { Faker::Internet.email }
      provider :email
    end

    trait :phone do
      uid      { Faker::PhoneNumber.phone_number }
      provider :phone
    end

    trait :verified do
      verified_at Faker::Date.between(2.weeks.ago, 1.day.ago)
    end

    user
  end
end
