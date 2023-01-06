require 'rails_helper'

RSpec.describe "Admin Invoices Edit" do
  let!(:customer) {Customer.create!(first_name: "Bob", last_name: "Bobbert")}
  let!(:invoice1) {customer.invoices.create!(status: 0)}

  let!(:merchant1) {Merchant.create!(name: "Hockey Stop and Shop")}
  let!(:item1) {merchant1.items.create!(name: "Socks", description: "They're good socks.", unit_price: 1200)}
  let!(:invoice_item1) {InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 1200, status: 1)}

  describe "User Story 36" do
    it "edit Invoice Status" do
      # When I visit an admin invoice show page
      visit admin_invoice_path(invoice1.id)
      # I see the invoice status is a select field
      expect(page).to have_select("Status")
      # And I see that the invoice's current status is selected
      expect(select).to eq(invoice1.status)
      # When I click this select field,
      # Then I can select a new status for the Invoice,
      select "Status", with 1
      # And next to the select field I see a button to "Update Invoice Status"
      expect(page).to have_button "Update Invoice Status"
      # When I click this button
      click_button "Update Invoice Status"
      # I am taken back to the admin invoice show page
      expect(current_path).to eq admin_invoice_path(invoice1.id)
      # And I see that my Invoice's status has now been updated
      expect(invoice1.status).to eq 1
    end
  end
end