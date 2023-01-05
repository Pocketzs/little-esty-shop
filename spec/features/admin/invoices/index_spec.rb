require 'rails_helper'

RSpec.describe "Admin Invoices Index" do
  let!(:customer) {Customer.create!(first_name: "Bob", last_name: "Bobbert")}
  let!(:invoice1) {customer.invoices.create!(status: 0)}
  let!(:invoice2) {customer.invoices.create!(status: 0)}
  let!(:invoice3) {customer.invoices.create!(status: 0)}

  describe "User Story 32" do
    it "lists all invoice ids" do
      # When I visit the admin Invoices index ("/admin/invoices")
      visit admin_invoices_path
      # Then I see a list of all Invoice ids in the system
      expect(page).to have_content("Invoice ##{invoice1.id}")
      expect(page).to have_content("Invoice ##{invoice3.id}")
      expect(page).to have_content("Invoice ##{invoice2.id}")
    end
    
    it "each id links to admin invoice show page" do
      visit admin_invoices_path
      
      # Each id links to the admin invoice show page
      click_link ("Invoice ##{invoice1.id}")
      expect(current_path).to eq(admin_invoice_path(invoice1.id))
    end
  end
  
end