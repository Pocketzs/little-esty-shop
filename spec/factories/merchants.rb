FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
    factory :merchant_with_items do
      transient do # this passes to options below 
        num { 5 }
      end

      before(:create) do |merchant,options|
        options.num.times do
          create(:item, merchant: merchant)
        end
      end
    end
  end
end