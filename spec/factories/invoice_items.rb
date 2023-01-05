FactoryBot.define do
  factory :invoice_item do
    item 
    invoice 
    quantity { rand(1..8) }
    unit_price { [rand(99..999), rand(99..999), rand(1000..9999), rand(100000..999999)].sample }
    status { [1..3].sample }
  end
end
