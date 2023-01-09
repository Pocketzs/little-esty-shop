require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:merchants).through(:items)}
  end
  
  describe 'validations' do
    it { should define_enum_for(:status) }
  end

  describe 'instance variables' do
    let!(:customer) {Customer.create!(first_name: "Bob", last_name: "Bobbert")}
    let!(:invoice1) {customer.invoices.create!(status: 0)}
    let!(:invoice2) {customer.invoices.create!(status: 0)}
    let!(:merchant1) {Merchant.create!(name: "Hockey Stop and Shop")}
    let!(:item1) {merchant1.items.create!(name: "Socks", description: "They're good socks.", unit_price: 1200)}
    let!(:item2) {merchant1.items.create!(name: "Tape", description: "For taping.", unit_price: 600)}
    let!(:invoice_item1) {InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 2, unit_price: 1200, status: 1)}
    let!(:invoice_item2) {InvoiceItem.create!(invoice_id: invoice1.id, item_id: item2.id, quantity: 1, unit_price: 600, status: 1)}

    it "total_revenue" do
      expect(invoice1.total_revenue).to eq(3000)
    end
  end
end
