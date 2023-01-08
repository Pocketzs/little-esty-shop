require 'rails_helper'

RSpec.describe "Admin Dashboard Index Page" do
  let!(:customer) {Customer.create!(first_name: "Bob", last_name: "Bobbert")}
  let!(:invoice1) {customer.invoices.create!(status: 0)}
  let!(:invoice2) {customer.invoices.create!(status: 1)}
  let!(:invoice3) {customer.invoices.create!(status: 2)}
  let!(:merchant1) {Merchant.create!(name: "Hockey Stop and Shop")}
  let!(:item1) {merchant1.items.create!(name: "Socks", description: "They're good socks.", unit_price: 1200)}
  let!(:item2) {merchant1.items.create!(name: "Tape", description: "For taping.", unit_price: 600)}
  let!(:invoice_item1) {InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 1200, status: 0)}
  let!(:invoice_item2) {InvoiceItem.create!(invoice_id: invoice2.id, item_id: item2.id, quantity: 1, unit_price: 600, status: 0)}
  let!(:invoice_item3) {InvoiceItem.create!(invoice_id: invoice3.id, item_id: item2.id, quantity: 1, unit_price: 0, status: 2)}

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
        expect(page).to_not have_content("Invoice ##{invoice3.id}")
        
        # And each invoice id links to that invoice's admin show page
        expect(page).to have_link(invoice1.id)
        click_link invoice1.id
        expect(current_path).to eq admin_invoice_path(invoice1)
      end
    end
  end
end