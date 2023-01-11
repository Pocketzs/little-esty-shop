require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items } 
    it { should have_many(:invoice_items).through(:items) } 
    it { should have_many(:invoices).through(:invoice_items) } 
  end

  describe 'validations' do
    it { should validate_presence_of :name } 
    it { should define_enum_for(:status) } 
  end

  describe 'methods' do
    let!(:merchant1) {create(:merchant)}
    let!(:merchant2) {create(:merchant)}
    let!(:merchant3) {create(:merchant)}
    let!(:merchant4) {create(:merchant)}
    let!(:merchant5) {create(:merchant)}
    let!(:merchant6) {create(:merchant)}

    let!(:customer) {create(:customer)}

    let!(:item1) {create(:item, merchant_id: merchant1.id)}
    let!(:item2) {create(:item, merchant_id: merchant2.id)}
    let!(:item3) {create(:item, merchant_id: merchant3.id)}
    let!(:item4) {create(:item, merchant_id: merchant4.id)}
    let!(:item5) {create(:item, merchant_id: merchant5.id)}
    let!(:item6) {create(:item, merchant_id: merchant6.id)}

    let!(:invoice1) {create(:invoice, customer_id: customer.id)}
    let!(:invoice2) {create(:invoice, customer_id: customer.id)}
    let!(:invoice3) {create(:invoice, customer_id: customer.id)}
    let!(:invoice4) {create(:invoice, customer_id: customer.id)}
    let!(:invoice5) {create(:invoice, customer_id: customer.id)}
    let!(:invoice6) {create(:invoice, customer_id: customer.id)}

    let!(:invoice_item1) {create(:invoice_item, invoice_id: invoice1.id, item_id:item1.id, quantity: 1, unit_price: 100)}
    let!(:invoice_item2) {create(:invoice_item, invoice_id: invoice2.id, item_id:item2.id, quantity: 1, unit_price: 200)}
    let!(:invoice_item3) {create(:invoice_item, invoice_id: invoice3.id, item_id:item3.id, quantity: 1, unit_price: 300)}
    let!(:invoice_item4) {create(:invoice_item, invoice_id: invoice4.id, item_id:item4.id, quantity: 1, unit_price: 400)}
    let!(:invoice_item5) {create(:invoice_item, invoice_id: invoice5.id, item_id:item5.id, quantity: 1, unit_price: 500)}
    let!(:invoice_item6) {create(:invoice_item, invoice_id: invoice6.id, item_id:item6.id, quantity: 1, unit_price: 600)}

    let!(:transaction1) {create(:transaction, invoice_id: invoice1.id, result: 1)}
    let!(:transaction2) {create(:transaction, invoice_id: invoice2.id, result: 1)}
    let!(:transaction3) {create(:transaction, invoice_id: invoice3.id, result: 1)}
    let!(:transaction4) {create(:transaction, invoice_id: invoice4.id, result: 1)}
    let!(:transaction5) {create(:transaction, invoice_id: invoice5.id, result: 1)}
    let!(:transaction6) {create(:transaction, invoice_id: invoice6.id, result: 1)}

    describe 'class methods' do
      it "top 5 merchants by revenue" do
        expect(Merchant.top_five_by_revenue).to eq ([merchant6, merchant5, merchant4, merchant3, merchant2, merchant1])
      end
    end

    describe 'instance methods' do
      it "total_revenue" do
        expect(merchant6.total_revenue).to eq(600)
        
        # invoices need at least one "successful" transaction to be counted
        invoice_no_success = create(:invoice, customer_id: customer.id)
        invoice_item_no_success = create(:invoice_item, invoice_id: invoice_no_success.id, item_id: item6.id, quantity: 1, unit_price: 100)
        transaction_no_success = create(:transaction, invoice_it: invoice_no_success.id, result: 0)
        
        expect(merchant6.total_revenue).to eq(600)

        transaction_success = create(:transaction, invoice_it: invoice_no_success.id, result: 1)
        
        expect(merchant6.total_revenue).to eq(700)
      end
    end
  end
end
