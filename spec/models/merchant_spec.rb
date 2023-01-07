require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do
    @merchant = create(:merchant) 
    @item1, @item2, @item3, = create_list(:item, 3, merchant: @merchant) 
    @item4, @item5 = create_list(:item, 2, merchant: @merchant, status: "enabled") 
  end

  describe 'relationships' do
    it { should have_many :items } 
  end

  describe 'validations' do
    it { should validate_presence_of :name } 
  end

  describe '#enabled_items' do
    it "returns a merchant's enabled items" do
      expect(@merchant.enabled_items).to eq([@item4, @item5])
    end
  end

  describe '#disabled_items' do
    it "returns a merchant's disabled items" do
      expect(@merchant.disabled_items).to eq([@item1, @item2, @item3])
    end
  end
end
