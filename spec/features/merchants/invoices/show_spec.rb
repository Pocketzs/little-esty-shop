# 16. Merchant Invoice Show Page: Invoice Item Information

# As a merchant
# When I visit my merchant invoice show page
# Then I see all of my items on the invoice including:
# - Item name
# - The quantity of the item ordered
# - The price the Item sold for
# - The Invoice Item status
# And I do not see any information related to Items for other merchants
require "rails_helper" 

RSpec.describe 'The Merchant Invoices Show page', type: :feature do
  let!(:merchant1) { Merchant.create!(name: "Billy's Butters") }
  let!(:merchant2) { Merchant.create!(name: "Sandy's Sandwiches") }

  let!(:item1) { Item.create!(name: "Tissues", description: "Wipes Nose", unit_price: 1000, merchant: merchant1) }
  let!(:item2) { Item.create!(name: "Apples", description: "Delicious", unit_price: 1200, merchant: merchant1) }
  let!(:item3) { Item.create!(name: "Pizza", description: "Cheezy Delicious", unit_price: 1749, merchant: merchant1) }
  let!(:item4) { Item.create!(name: "Penguins", description: "Exotic pet", unit_price: 100005, merchant: merchant1) }

  let!(:invoice_item1) { InvoiceItem.create!(quantity: 2, unit_price: 1000, item: item1, invoice: invoice1, status: 0) }
  let!(:invoice_item2) { InvoiceItem.create!(quantity: 6, unit_price: 1200, item: item2, invoice: invoice1, status: 1) }
  let!(:invoice_item3) { InvoiceItem.create!(quantity: 1, unit_price: 1749, item: item3, invoice: invoice2, status: 2) }
  let!(:invoice_item4) { InvoiceItem.create!(quantity: 2, unit_price: 100005, item: item4, invoice: invoice3, status: 1) }

  let!(:customer1) {Customer.create!(first_name: "Bob", last_name: "Bobbert")}
  let!(:customer2) {Customer.create!(first_name: "Chad", last_name: "Chaddert")}

  let!(:invoice1) {customer1.invoices.create!(status: 0)}
  let!(:invoice2) {customer1.invoices.create!(status: 1)}
  let!(:invoice3) {customer2.invoices.create!(status: 2)}

  describe "When I visit the merchants invoice show page" do #us15
    it "shows information related to that invoice including :id, status, create_at, customer first and last name" do
      visit merchant_invoice_path(merchant1.id, invoice1.id)

      expect(page).to have_content(invoice1.id)
      expect(page).to have_content(invoice1.status)
      expect(page).to have_content(invoice1.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(customer1.first_name)
      expect(page).to have_content(customer1.last_name)
    end
  end

  describe "when I visit the merchant invoice show page" do
    it "then I see all of my items on the invoice invluding: name, quanity, price, status" do #us 16
      visit merchant_invoice_path(merchant1.id, invoice1.id)
    
save_and_open_page
      expect(page).to have_content(item1.name)
      expect(page).to have_content(invoice_item1.quantity)
      expect(page).to have_content(invoice_item1.unit_price)
      expect(page).to have_content(invoice_item1.status)
    end  
  end
end
