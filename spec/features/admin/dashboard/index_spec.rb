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
      # When I visit the admin dashboard (/admin)
      visit admin_dashboard_index_path
      
      # Then I see a header indicating that I am on the admin dashboard
      expect(page).to have_content("Admin Dashboard Index Page")
    end
  end
  
  describe "User Story 20" do
    it "contains links" do
      # When I visit the admin dashboard (/admin)
      visit admin_dashboard_index_path
      
      # Then I see a link to the admin merchants index (/admin/merchants)
      expect(page).to have_link("Admin Merchant Index")
      # And I see a link to the admin invoices index (/admin/invoices)
      expect(page).to have_link("Admin Invoice Index")
    end
  end
  
  describe "User Story 21" do
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
    # let!(:invoice_item1) {create(:invoice_item,invoice_id: invoice1.id, 
    #                               item_id: item1.id, quantity: 1, 
    #                               unit_price: 1, status: 2)}
    # let!(:invoice_item2) {create(:invoice_item,invoice_id: invoice2.id, 
    #                               item_id: item1.id, quantity: 2, 
    #                               unit_price: 1, status: 2)}
    # let!(:invoice_item3) {create(:invoice_item,invoice_id: invoice3.id, 
    #                               item_id: item1.id, quantity: 3, 
    #                               unit_price: 1, status: 2)}
    # let!(:invoice_item4) {create(:invoice_item,invoice_id: invoice4.id, 
    #                               item_id: item1.id, quantity: 4, 
    #                               unit_price: 1, status: 2)}
    # let!(:invoice_item5) {create(:invoice_item,invoice_id: invoice5.id, 
    #                               item_id: item1.id, quantity: 5, 
    #                               unit_price: 1, status: 2)}
    # let!(:invoice_item6) {create(:invoice_item,invoice_id: invoice6.id, 
    #                               item_id: item1.id, quantity: 6, 
    #                               unit_price: 1, status: 2)}
    
    it "displays 5 customers with most transactions (successful)" do
      visit admin_dashboard_index_path
      
      within ("#top_customers") do
        # Then I see the names of the top 5 customers
        # who have conducted the largest number of successful transactions
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
        
        # And next to each customer name I see the number of successful transactions they have
        # conducted
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
    
    describe "User Story 22" do
      it "section for incomplete invoices" do
        # When I visit the admin dashboard
        visit admin_dashboard_index_path
        
        # Then I see a section for "Incomplete Invoices"
        within ("#incomplete_invoices") do
          expect(page).to have_content("Incomplete Invoices")
          # In that section I see a list of the ids of all invoices
          # That have items that have not yet been shipped
          expect(page).to have_content("Invoice ##{invoice1.id}")
        expect(page).to have_content("Invoice ##{invoice2.id}")
        expect(page).to have_content("Invoice ##{invoice4.id}")
        expect(page).to_not have_content("Invoice ##{invoice3.id}")
        
        # And each invoice id links to that invoice's admin show page
        expect(page).to have_link(invoice1.id)
        click_link invoice1.id
        expect(current_path).to eq admin_invoice_path(invoice1)
      end
    end
  end
  
  describe "User Story 23" do
    it "orders incomplete invoices by oldest to newest" do
      # When I visit the admin dashboard
      visit admin_dashboard_index_path
      
      # In the section for "Incomplete Invoices",
      within ("#incomplete_invoices") do
        # Next to each invoice id I see the date that the invoice was created
        # And I see the date formatted like "Monday, July 18, 2019"

        within ("#invoice_id_#{invoice1.id}") do
          expect(page).to have_content("Friday, May 11, 2018")
        end

        within ("#invoice_id_#{invoice2.id}") do
          expect(page).to have_content("Tuesday, June 12, 2018")
        end

        within ("#invoice_id_#{invoice4.id}") do
          expect(page).to have_content("Thursday, July 13, 2017")
        end
        
        # And I see that the list is ordered from oldest to newest
        expect(invoice4.created_at.strftime("%A, %B %d, %Y")).to appear_before(invoice1.created_at.strftime("%A, %B %d, %Y"))
        expect(invoice4.created_at.strftime("%A, %B %d, %Y")).to appear_before(invoice2.created_at.strftime("%A, %B %d, %Y"))
        expect(invoice1.created_at.strftime("%A, %B %d, %Y")).to appear_before(invoice2.created_at.strftime("%A, %B %d, %Y"))
      end
    end
  end
end