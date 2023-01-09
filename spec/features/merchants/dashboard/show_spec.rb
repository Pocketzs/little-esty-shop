require 'rails_helper'

RSpec.describe 'Merchant Dashboard Index', type: :feature do
  let!(:merchant) { Merchant.create!(name: "Bill's Boardshop") }

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

    xit 'the I see the names of the top 5 customers who have conducted the largest number of transactions' do #us 3
      let!(:merchant1) {create(:merchant)}
      
      let!(:item1)     {create(:item, merchant_id: merchant1.id)}
      
      let!(:customer1) {create(:customer)} 
      let!(:customer2) {create(:customer)} 
      let!(:customer3) {create(:customer)} 
      let!(:customer4) {create(:customer)} 
      let!(:customer5) {create(:customer)} 
      let!(:customer6) {create(:customer)} 
      
      let!(:invoice1)  {create(:invoice, customer_id: customer1.id)}
      let!(:invoice2)  {create(:invoice, customer_id: customer2.id)}
      let!(:invoice3)  {create(:invoice, customer_id: customer3.id)}
      let!(:invoice4)  {create(:invoice, customer_id: customer4.id)}
      let!(:invoice5)  {create(:invoice, customer_id: customer5.id)}
      let!(:invoice6)  {create(:invoice, customer_id: customer6.id)}
      
      let!(:transaction1) {1.times do create(:transaction, invoice_id: invoice1.id, result: 1) end}
      let!(:transaction2) {2.times do create(:transaction, invoice_id: invoice2.id, result: 1) end}
      let!(:transaction3) {3.times do create(:transaction, invoice_id: invoice3.id, result: 1) end}
      let!(:transaction4) {4.times do create(:transaction, invoice_id: invoice4.id, result: 1) end}
      let!(:transaction5) {5.times do create(:transaction, invoice_id: invoice5.id, result: 1) end}
      let!(:transaction6) {6.times do create(:transaction, invoice_id: invoice6.id, result: 1) end}
      
      within ("#top_customers") do
        expect(page).to have_content("Top Customers:") 
        expect(page).to have_content(customer2.first_name) 
        expect(page).to have_content(customer2.last_name) 
        expect(page).to have_content(customer3.first_name) 
        expect(page).to have_content(customer3.last_name) 
        expect(page).to have_content(customer4.first_name) 
        expect(page).to have_content(customer4.last_name) 
        expect(page).to have_content(customer5.first_name) 
        expect(page).to have_content(customer5.last_name) 
        expect(page).to have_content(customer6.first_name) 
        expect(page).to have_content(customer6.last_name) 
        expect(page).to_not have_content(customer1.first_name) 
        expect(page).to_not have_content(customer1.last_name) 

        
    end
    xit "next to each customers name I see the number of successful transactions they have" do
      within ("#customer_id#{customer2.id}") do
          expect(page).to have_content(customer2.transactions.count)
        end
        within ("#customer_id#{customer3.id}") do
          expect(page).to have_content(customer3.transactions.count)
        end
        within ("#customer_id#{customer4.id}") do
          expect(page).to have_content(customer4.transactions.count)
        end
        within ("#customer_id#{customer5.id}") do
          expect(page).to have_content(customer5.transactions.count)
        end
        within ("#customer_id#{customer6.id}") do
          expect(page).to have_content(customer6.transactions.count)
        end
      end
    end
  end
end
