FactoryBot.define do
  factory :article do
    title Faker::Lorem.paragraph
    body  Faker::Lorem.sentences
  end
end
