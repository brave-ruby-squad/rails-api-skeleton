FactoryBot.define do
  factory :identity do
    trait :email do
      uid      { Faker::Internet.email }
      provider 'email'.freeze
    end

    trait :phone do
      uid      { Faker::PhoneNumber.phone_number }
      provider 'phone'.freeze
    end

    user
  end
end
