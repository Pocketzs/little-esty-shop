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
    describe 'class methods' do
      it "top 5 merchants by revenue"
    end
  end
end
