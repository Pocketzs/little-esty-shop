require 'rails_helper'

RSpec.describe "Admin Dashboard Index Page" do
  
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
        expect(page).to have_content("Invoice ##{invoice3.id}")
        
        # And each invoice id links to that invoice's admin show page
        expect(page).to have_link(invoice1.id)
        click_link invoice1.id
        expect(current_path).to eq admin_invoice_path(invoice1)
      end
    end
  end
end