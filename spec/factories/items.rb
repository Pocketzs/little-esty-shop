FactoryBot.define do
  factory :item do
    name { Faker::Camera.brand_with_model }
    description { Faker::Coffee.notes }
    unit_price { [rand(100..9999), rand(100..9999), rand(1000..99999), rand(100000..9999999)].sample }
    merchant
    
    # an example of a trait that can be declared/requested in let block
    trait :stocked do
      stocked { true }
    end
    
    factory :stocked_item, traits: [:stocked]
end
