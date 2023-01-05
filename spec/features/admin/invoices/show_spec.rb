require 'rails_helper'

RSpec.describe "Admin Invoices Show" do
  let!(:customer) {Customer.create!(first_name: "Bob", last_name: "Bobbert")}
  let!(:invoice1) {customer.invoices.create!(status: 0)}
  let!(:invoice2) {customer.invoices.create!(status: 0)}
  let!(:merchant1) {Merchant.create!(name: "Hockey Stop and Shop")}
  let!(:item1) {merchant1.items.create!(name: "Socks", description: "They're good socks.", unit_price: 1200)}
  let!(:invoice_item1) {InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 1200, status: 1)}

  describe "User Story 33" do
    it "lists specific invoice info" do
      # When I visit an admin invoice show page
      visit admin_invoice_path(invoice1.id)
      # Then I see information related to that invoice including:
      # Invoice id
      expect(page).to have_content(invoice1.id)
      # Invoice status
      expect(page).to have_content(invoice1.status)
      # Invoice created_at date in the format "Monday, July 18, 2019"
      expect(page).to have_content(invoice1.created_at.strftime("%A, %B %d, %Y"))
      # Customer first and last name
      expect(page).to have_content(customer.first_name)
      expect(page).to have_content(customer.last_name)
      expect(page).to_not have_content(invoice2.id)
    end
  end

  describe "User Story 34" do
    it "invoice item information" do
      # When I visit an admin invoice show page
      visit admin_invoice_path(invoice1.id)
      # Then I see all of the items on the invoice including:
      # Item name
      expect(page).to have_content(invoice_item1.item.name)
      # The quantity of the item ordered
      expect(page).to have_content(invoice_item1.quantity)
      # The price the Item sold for
      expect(page).to have_content(invoice_item1.unit_price)
      # The Invoice Item status
      expect(page).to have_content(invoice_item1.status)
    end
  end

  describe "User Story 35" do
    it "total revenue" do
      # When I visit an admin invoice show page
      visit admin_invoice_path(invoice1.id)
      # Then I see the total revenue that will be generated from this invoice
      expect(page).to have_content(invoice1.total_revenue)
    end
  end
end

