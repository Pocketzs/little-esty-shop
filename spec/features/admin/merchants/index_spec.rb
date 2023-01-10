require 'rails_helper'

RSpec.describe "Admin Merchants Index" do
  let!(:merchant1) {FactoryBot.create(:merchant)}
  let!(:merchant2) {FactoryBot.create(:merchant)}
  let!(:merchant3) {FactoryBot.create(:merchant)}
  describe "User Story 26" do
    it "lists merchants in system" do
      # When I visit the admin merchants index (/admin/merchants)
      visit admin_merchants_path
      # Then I see the name of each merchant in the system
      expect(page).to have_content(merchant1.name)
      expect(page).to have_content(merchant2.name)
      expect(page).to have_content(merchant3.name)
    end
  end

  describe "User Story 30" do
    it "top 5 merchants by revenue" 

      # As an admin,
      # When I visit the admin merchants index
      # Then I see the names of the top 5 merchants by total revenue generated
      # And I see that each merchant name links to the admin merchant show page for that merchant
      # And I see the total revenue generated next to each merchant name

      # Notes on Revenue Calculation:

      # Only invoices with at least one successful transaction should count towards revenue
      # Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
      # Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)

  end
  
end