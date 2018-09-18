FactoryBot.define do
  factory :user_params, class: Hash do
    password              { SecureRandom.base64(6) }
    password_confirmation { password }

    trait :email do
      email { Faker::Internet.email }
    end

    trait :phone do
      phone { Faker::PhoneNumber.phone_number }
    end

    initialize_with { attributes }
  end
end
