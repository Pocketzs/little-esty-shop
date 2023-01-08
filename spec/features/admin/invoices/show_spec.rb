require 'rails_helper'

RSpec.describe "Admin Invoices Show" do
  let!(:customer) {Customer.create!(first_name: "Bob", last_name: "Bobbert")}
  let!(:invoice1) {customer.invoices.create!(status: 1)}
  let!(:invoice2) {customer.invoices.create!(status: 1)}

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
end

