FactoryBot.define do
  factory :article do
    title { Faker::Dessert.variety }
    body  { Faker::ChuckNorris.fact }
  end
end
