FactoryBot.define do
  factory :article do
    title Faker::Superhero.name
    body  Faker::Lorem.paragraph
  end
end
