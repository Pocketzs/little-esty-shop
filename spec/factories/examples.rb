# # FactoryBot Usage Examples
# require 'rails_helper'

# RSpec.describe 'the index page', type: :feature do
#   let!(:merchant) { create(:merchant_with_items) }
#   let!(:item) { create(:item) }
#   let!(:stocked_item1) { create(:stocked_item) }
# end

# it 'brians example from thursday' do
#   merchant = create(:merchant)
#   item1, item2, item3, item4 = create_list(:item, 4, merchant: merchant)
# end

# examples of specifying traits in factories
# FactoryBot.define do
#   factory :xitem do
#     name { Faker::Camera.brand_with_model }
#     description { Faker::Coffee.notes }
#     unit_price { [rand(100..9999), rand(100..9999), rand(1000..99999), rand(100000..9999999)].sample }
#     merchant

#     # an example of a trait that can be declared/requested in let block
#     trait :stocked do
#       stocked { true }
#     end
    
#     # factory :stocked_item, traits: [:stocked]
#   end
# end

# nested in merchant factory

# factory :merchant_with_items do
#   transient do # this passes to options below 
#     num { 5 }
#   end

#   before(:create) do |merchant,options|
#     options.num.times do
#       create(:item, merchant: merchant)
#     end
#   end