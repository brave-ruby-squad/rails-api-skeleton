FactoryBot.define do
  factory :identity do
    uid      { Faker::Internet.email }
    provider :email

    user
  end
end
