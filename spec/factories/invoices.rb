FactoryBot.define do
  factory :invoice do
    customer_id 
    status { [1,2,3].sample }
  end
end
