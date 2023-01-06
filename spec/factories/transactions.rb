FactoryBot.define do
  factory :transaction do
    invoice 
    credit_card_number { Faker::Finance.credit_card.delete("-") }
    credit_card_expiration_date { "2023-01-03 15:02:58" }
    result { [0, 1].sample }
  end
end
