FactoryBot.define do
  factory :item do
    name {Faker::Commerce.product_name}
    description {Faker::Coffee.notes}
    unit_price { 1 } #Faker::Commerce.price(range: 0..10.0, as_string: true)
    merchant { nil }
  end
end


#GitHub page with commerce faker stuff: https://github.com/faker-ruby/faker/blob/main/doc/default/commerce.md