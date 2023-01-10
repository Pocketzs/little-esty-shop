FactoryBot.define do
  factory :invoice do
    customer_id { nil }
    status { [0,1,2].sample }
  end
end
