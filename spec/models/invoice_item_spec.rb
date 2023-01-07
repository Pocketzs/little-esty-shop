require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'validations' do
    it { should define_enum_for(:status)}
  end

#### NO INSTANCE VARIABLES APPLIED TO INVOICEITEM, YET. LEAVING THIS HERE IN CASE WE DO #### 
  # describe 'instance variables' do
  #   let!(:customer) {Customer.create!(first_name: "Bob", last_name: "Bobbert")}
  #   let!(:merchant1) {Merchant.create!(name: "Hockey Stop and Shop")}
  #   let!(:invoice1) {customer.invoices.create!(status: 0)}
  #   let!(:item1) {merchant1.items.create!(name: "Socks", description: "They're good socks.", unit_price: 1200)}
  #   let!(:invoice_item1) {InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 1200, status: 1)}

  #   it 'total_item_price' do
  #     expect(invoice_item1.total_item_price).to eq(2400)
  #   end
  # end
end
