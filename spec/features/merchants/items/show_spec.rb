# 7. Merchant Items Show Page

# As a merchant,
# When I click on the name of an item from the merchant items index page,
# Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)
# And I see all of the item's attributes including:

# - Name
# - Description
# - Current Selling Price

# 8. Merchant Item Update

# As a merchant,
# When I visit the merchant show page of an item
# I see a link to update the item information.
# When I click the link
# Then I am taken to a page to edit this item
# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.
require 'rails_helper'

RSpec.describe 'The Merchant Items Show page', type: :feature do
  let!(:merchant1) { Merchant.create!(name: "Billy's Butters") }

  let!(:item1) { Item.create!(name: "Tissues", description: "Wipes Nose", unit_price: 1000, merchant: merchant1) }
  let!(:item2) { Item.create!(name: "Apples", description: "Delicious", unit_price: 1200, merchant: merchant1) }
  
  it "show all the items attributes" do
    visit merchant_item_path(merchant1.id, item1.id)

    expect(page).to have_content("Name: #{item1.name}")
    expect(page).to have_content("Description: #{item1.description}")
    expect(page).to have_content("Current selling price: #{item1.unit_price}")
    
    expect(page).to_not have_content("Name: #{item2.name}")
    expect(page).to_not have_content("Description: #{item2.description}")
    expect(page).to_not have_content("Current selling price: #{item2.unit_price}")
  end

  describe "When I visit the merchant show page of an item" do
    it 'I see a link to update the item information' do
      visit merchant_item_path(merchant1.id, item1.id)

      click_link("Edit")

      # expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}/edit")
      expect(current_path).to eq(edit_merchant_item_path(merchant1.id, item1.id))
    end
  end
end

