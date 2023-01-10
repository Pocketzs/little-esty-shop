require 'rails_helper'

RSpec.describe 'The Merchant Items Show page', type: :feature do
  let!(:merchant1) { Merchant.create!(name: "Billy's Butters") }

  let!(:item1) { Item.create!(name: "Tissues", description: "Wipes Nose", unit_price: 1000, merchant: merchant1) }
  let!(:item2) { Item.create!(name: "Apples", description: "Delicious", unit_price: 1200, merchant: merchant1) }
  
  it "show all the items attributes" do
    visit merchant_item_path(merchant1.id, item1.id)

    expect(page).to have_content("Name: #{item1.name}")
    expect(page).to have_content("Description: #{item1.description}")
    expect(page).to have_content("Current Selling Price: #{item1.unit_price}")
    
    expect(page).to_not have_content("Name: #{item2.name}")
    expect(page).to_not have_content("Description: #{item2.description}")
    expect(page).to_not have_content("Current Selling Price: #{item2.unit_price}")
  end

  describe "When I visit the merchant show page of an item" do
    it 'I see a link to update the item information' do
      visit merchant_item_path(merchant1.id, item1.id)
      click_link("Edit")

      expect(current_path).to eq(edit_merchant_item_path(merchant1.id, item1.id))
    end
  end
end

