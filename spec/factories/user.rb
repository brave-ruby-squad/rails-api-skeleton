FactoryBot.define do
  factory :user do
    name                  { Faker::Name.name }

    password              { SecureRandom.base64(8) }
    password_confirmation { password }

    trait :email do
      after(:create) { |user| user.identities << create(:identity, :email) }
    end

    trait :phone do
      after(:create) { |user| user.identities << create(:identity, :phone) }
    end

    trait :token do
      after(:create) { |user| user.tokens << create(:token) }
    end
  end
end
