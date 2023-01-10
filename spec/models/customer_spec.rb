require 'rails_helper'

RSpec.describe Customer, type: :model do
  let!(:customer) { Customer.create!(first_name: "A Name", last_name: "A Last Name") }
  describe 'the customer model' do
    it { should have_many :invoices }
  end
  
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe "Methods" do
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
    
    describe "class methods" do
      it "self.top_five_successful_transactions" do
        expect(Customer.top_five_successful_transactions).to eq([customer6, customer5, customer4, customer3, customer2])
      end
    end

    describe "instance methods" do
      it "count_successful_transactions" do
        expect(customer1.count_successful_transactions).to eq 1
        expect(customer2.count_successful_transactions).to eq 2
        expect(customer3.count_successful_transactions).to eq 3
        expect(customer4.count_successful_transactions).to eq 4
      end
    end
    
  end
  
end