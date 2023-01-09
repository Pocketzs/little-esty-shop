require 'rails_helper'

RSpec.describe Merchant, type: :model do
  
  describe 'relationships' do
    it { should have_many :items } 
    it { should have_many(:invoice_items).through(:items) } 
    it { should have_many(:invoices).through(:invoice_items) } 
  end

  describe 'validations' do
    it { should validate_presence_of :name } 
  end

  describe 'methods' do
    let!(:merchant) { Merchant.create!(name: "Bill's Boardshop") }

    let!(:merchant1) {create(:merchant)}
    
    let!(:item1)     {create(:item, merchant_id: merchant.id)}
    
    let!(:customer1) {create(:customer)} 
    let!(:customer2) {create(:customer)} 
    let!(:customer3) {create(:customer)} 
    let!(:customer4) {create(:customer)} 
    let!(:customer5) {create(:customer)} 
    let!(:customer6) {create(:customer)} 
    
    let!(:invoice1)  {create(:invoice, customer_id: customer1.id)}
    let!(:invoice2)  {create(:invoice, customer_id: customer2.id)}
    let!(:invoice3)  {create(:invoice, customer_id: customer3.id)}
    let!(:invoice4)  {create(:invoice, customer_id: customer4.id)}
    let!(:invoice5)  {create(:invoice, customer_id: customer5.id)}
    let!(:invoice6)  {create(:invoice, customer_id: customer6.id)}
    
    let!(:transaction1) {1.times do create(:transaction, invoice_id: invoice1.id, result: 1) end}
    let!(:transaction2) {2.times do create(:transaction, invoice_id: invoice2.id, result: 1) end}
    let!(:transaction3) {3.times do create(:transaction, invoice_id: invoice3.id, result: 1) end}
    let!(:transaction4) {4.times do create(:transaction, invoice_id: invoice4.id, result: 1) end}
    let!(:transaction5) {5.times do create(:transaction, invoice_id: invoice5.id, result: 1) end}
    let!(:transaction6) {6.times do create(:transaction, invoice_id: invoice6.id, result: 1) end}

    let!(:invoice_item1) {create(:invoice_item,invoice_id: invoice1.id, 
                                  item_id: item1.id, quantity: 1, 
                                  unit_price: 1, status: 2)}
    let!(:invoice_item2) {create(:invoice_item,invoice_id: invoice2.id, 
                                  item_id: item1.id, quantity: 2, 
                                  unit_price: 1, status: 2)}
    let!(:invoice_item3) {create(:invoice_item,invoice_id: invoice3.id, 
                                  item_id: item1.id, quantity: 3, 
                                  unit_price: 1, status: 2)}
    let!(:invoice_item4) {create(:invoice_item,invoice_id: invoice4.id, 
                                  item_id: item1.id, quantity: 4, 
                                  unit_price: 1, status: 2)}
    let!(:invoice_item5) {create(:invoice_item,invoice_id: invoice5.id, 
                                  item_id: item1.id, quantity: 5, 
                                  unit_price: 1, status: 2)}
    let!(:invoice_item6) {create(:invoice_item,invoice_id: invoice6.id, 
                                  item_id: item1.id, quantity: 6, 
                                  unit_price: 1, status: 2)}

    it 'top_customers' do
      expect(merchant.top_customers).to eq([customer6, customer5, customer4, customer3, customer2])
    end
  end
end
