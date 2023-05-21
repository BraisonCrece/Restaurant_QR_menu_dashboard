FactoryBot.define do
  factory :allergen do
    after(:build) do |allergen|
      allergen.icon.attach(io: File.open(Rails.root.join("spec", "fixtures", "files", "test.jpg")), filename: "test.jpg")
    end
    name { Faker::Food.ingredient }
  end
end
