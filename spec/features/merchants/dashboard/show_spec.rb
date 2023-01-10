require 'rails_helper'

RSpec.describe 'Merchant Dashboard Index', type: :feature do
  let!(:merchant) { Merchant.create!(name: "Bill's Boardshop") }

  let!(:item1)     {FactoryBot.create(:item, merchant_id: merchant.id)}
  let!(:item2)     {FactoryBot.create(:item, merchant_id: merchant.id)}
  let!(:item3)     {FactoryBot.create(:item, merchant_id: merchant.id)}
  let!(:item4)     {FactoryBot.create(:item, merchant_id: merchant.id)}
  let!(:item5)     {FactoryBot.create(:item, merchant_id: merchant.id)}
  let!(:item6)     {FactoryBot.create(:item, merchant_id: merchant.id)}
  
  let!(:customer1) {FactoryBot.create(:customer)} 
  let!(:customer2) {FactoryBot.create(:customer)} 
  
  let!(:invoice1)  {FactoryBot.create(:invoice, customer_id: customer1.id)}
  let!(:invoice2)  {FactoryBot.create(:invoice, customer_id: customer2.id)}
  
  let!(:invoice_item1) {FactoryBot.create(:invoice_item, invoice_id: invoice1.id, 
                               item_id: item1.id, quantity: 1, 
                               unit_price: 1, status: 1)}
  let!(:invoice_item2) {FactoryBot.create(:invoice_item, invoice_id: invoice1.id, 
                               item_id: item2.id, quantity: 2, 
                               unit_price: 1, status: 1)}
  let!(:invoice_item3) {FactoryBot.create(:invoice_item, invoice_id: invoice1.id, 
                               item_id: item3.id, quantity: 3, 
                               unit_price: 1, status: 1)}
  let!(:invoice_item4) {FactoryBot.create(:invoice_item, invoice_id: invoice2.id, 
                               item_id: item4.id, quantity: 4, 
                               unit_price: 1, status: 1)}
  let!(:invoice_item5) {FactoryBot.create(:invoice_item, invoice_id: invoice2.id, 
                               item_id: item5.id, quantity: 5, 
                               unit_price: 1, status: 1)}
  let!(:invoice_item6) {FactoryBot.create(:invoice_item, invoice_id: invoice2.id, 
                               item_id: item6.id, quantity: 6, 
                               unit_price: 1, status: 1)}
  before :each do
    visit "/merchants/#{merchant.id}/dashboard" 
  end

  describe 'As a merchant, when I visit my merchant dashboard' do
    it 'displays the merchant name' do #us1
      expect(page).to have_content(merchant.name)
    end

    it 'shows a link to my merchant items index' do #us2
      expect(page).to have_link("Merchant Items Index")
      expect(page).to have_link("Merchant Invoices Index")
    end

    xit 'shows the names of the top 5 customers' do #us3
      # who have conducted the largest number of successful transactions
      # with my merchant and next to each customer name I see the total number of
      # successful transactions they have conducted
    end
  end
  
  describe 'As a merchant when I visit my merchant dashboard' do
    it "has a section for 'Items Ready to Ship'" do #us5
      within ('#ready_to_ship') do
        expect(page).to have_content(merchant.name)
      end
    end
    
    it 'has the date the invoice was created by each item' do
      # # And I see the date formatted like "Monday, July 18, 2019"
      # # And I see that the list is ordered from oldest to newest
    end
  end
  # # As a merchant
  # # When I visit my merchant dashboard
  # # In the section for "Items Ready to Ship",
  # # Next to each Item name I see the date that the invoice was created
  # # And I see the date formatted like "Monday, July 18, 2019"
  # # And I see that the list is ordered from oldest to newest
  
end