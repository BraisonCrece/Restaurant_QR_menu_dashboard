FactoryBot.define do
  factory :product do
    title { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    active { true }
    prize { Faker::Commerce.price(range: 100.0..1000.0) }
    category
  end
end
