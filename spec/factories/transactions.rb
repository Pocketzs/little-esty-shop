FactoryBot.define do
  factory :transaction do
    invoice 
    credit_card_number { Faker::Number.leading_zero_number(digits: 16) }
    credit_card_expiration_date { "2023-01-03 15:02:58" }
    result { 1 }
  end
end
