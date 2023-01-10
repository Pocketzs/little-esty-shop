require 'rails_helper'

RSpec.describe "Admin Dashboard Index Page" do
  let!(:customer) {Customer.create!(first_name: "Bob", last_name: "Bobbert")}
  let!(:invoice1) {customer.invoices.create!(created_at: DateTime.new(2018, 05, 11, 20, 10, 0), status: 0)}
  let!(:invoice2) {customer.invoices.create!(created_at: DateTime.new(2018, 06, 12, 20, 10, 0), status: 1)}
  let!(:invoice3) {customer.invoices.create!(status: 2)}
  let!(:invoice4) {customer.invoices.create!(created_at: DateTime.new(2017, 07, 13, 20, 10, 0), status: 0)}
  let!(:merchant1) {Merchant.create!(name: "Hockey Stop and Shop")}
  let!(:item1) {merchant1.items.create!(name: "Socks", description: "They're good socks.", unit_price: 1200)}
  let!(:item2) {merchant1.items.create!(name: "Tape", description: "For taping.", unit_price: 600)}
  let!(:invoice_item1) {InvoiceItem.create!(created_at: DateTime.new(2018, 05, 11, 20, 10, 0), invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 1200, status: 0)}
  let!(:invoice_item2) {InvoiceItem.create!(created_at: DateTime.new(2018, 06, 12, 20, 10, 0), invoice_id: invoice2.id, item_id: item2.id, quantity: 1, unit_price: 600, status: 0)}
  let!(:invoice_item3) {InvoiceItem.create!(invoice_id: invoice3.id, item_id: item2.id, quantity: 1, unit_price: 0, status: 2)}
  let!(:invoice_item4) {InvoiceItem.create!(created_at: DateTime.new(2017, 07, 13, 20, 10, 0), invoice_id: invoice4.id, item_id: item1.id, quantity: 1, unit_price: 0, status: 0)}
  
  describe "User Story 19" do
    it "header indicating admin dashboard" do
      visit admin_dashboard_index_path
      
      expect(page).to have_content("Admin Dashboard Index Page")
    end
  end
  
  describe "User Story 20" do
    it "contains links" do
      visit admin_dashboard_index_path
      
      expect(page).to have_link("Admin Merchant Index")
      expect(page).to have_link("Admin Invoice Index")
    end
  end
  
  describe "User Story 21" do
    # worth it to make a helper file for our let! blocks?
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
    
    it "displays 5 customers with most transactions (successful)" do
      visit admin_dashboard_index_path
      
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
        
        within ("#customer_id_#{customer2.id}") do
          expect(page).to have_content(customer2.transactions.count)
        end
        
        within ("#customer_id_#{customer3.id}") do
          expect(page).to have_content(customer3.transactions.count)
        end
        
        within ("#customer_id_#{customer4.id}") do
          expect(page).to have_content(customer4.transactions.count)
        end
        
        within ("#customer_id_#{customer5.id}") do
          expect(page).to have_content(customer5.transactions.count)
        end
        
        within ("#customer_id_#{customer6.id}") do
          expect(page).to have_content(customer6.transactions.count)
        end

        expect("#customer_id_6").to appear_before("#customer_id_5")
        expect("#customer_id_5").to appear_before("#customer_id_4")
        expect("#customer_id_4").to appear_before("#customer_id_3")
        expect("#customer_id_3").to appear_before("#customer_id_2")
      end
    end
  end
    
  describe "User Story 22" do
    it "section for incomplete invoices" do
      visit admin_dashboard_index_path
      
      within ("#incomplete_invoices") do
        expect(page).to have_content("Incomplete Invoices")
        expect(page).to have_content("Invoice ##{invoice1.id}")
        expect(page).to have_content("Invoice ##{invoice2.id}")
        expect(page).to have_content("Invoice ##{invoice4.id}")
        expect(page).to_not have_content("Invoice ##{invoice3.id}")
        
        expect(page).to have_link(invoice1.id)
        click_link invoice1.id
        expect(current_path).to eq admin_invoice_path(invoice1)
      end
    end
  end
  
  describe "User Story 23" do
    it "orders incomplete invoices by oldest to newest" do
      visit admin_dashboard_index_path
      
      within ("#incomplete_invoices") do

        within ("#invoice_id_#{invoice1.id}") do
          expect(page).to have_content("Friday, May 11, 2018")
        end

        within ("#invoice_id_#{invoice2.id}") do
          expect(page).to have_content("Tuesday, June 12, 2018")
        end

        within ("#invoice_id_#{invoice4.id}") do
          expect(page).to have_content("Thursday, July 13, 2017")
        end
        
        expect(invoice4.created_at.strftime("%A, %B %d, %Y")).to appear_before(invoice1.created_at.strftime("%A, %B %d, %Y"))
        expect(invoice4.created_at.strftime("%A, %B %d, %Y")).to appear_before(invoice2.created_at.strftime("%A, %B %d, %Y"))
        expect(invoice1.created_at.strftime("%A, %B %d, %Y")).to appear_before(invoice2.created_at.strftime("%A, %B %d, %Y"))
      end
    end
  end
end