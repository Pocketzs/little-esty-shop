# As a merchant,
# When I visit my merchant items index page ("merchants/merchant_id/items")
# I see a list of the names of all of my items
# And I do not see items for any other merchant

# 7. Merchant Items Show Page

# As a merchant,
# When I click on the name of an item from the merchant items index page,
# Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)
# And I see all of the item's attributes including:

# - Name
# - Description
# - Current Selling Price

# As a merchant
# When I visit my items index page
# Next to each item name I see a button to disable or enable that item.
# When I click this button
# Then I am redirected back to the items index
# And I see that the items status has changed

require 'rails_helper'

RSpec.describe 'The Merchant Items Index page', type: :feature do
  let!(:merchant1) { Merchant.create!(name: "Billy's Butters") }
  let!(:merchant2) { Merchant.create!(name: "Sandy's Sandwiches") }

  let!(:item1) { Item.create!(name: "Tissues", description: "Wipes Nose", unit_price: 1000, merchant: merchant1) }
  let!(:item2) { Item.create!(name: "Apples", description: "Delicious", unit_price: 1200, merchant: merchant1) }
  let!(:item3) { Item.create!(name: "Pizza", description: "Cheezy Delicious", unit_price: 1749, merchant: merchant1) }
  let!(:item4) { Item.create!(name: "Penguins", description: "Exotic pet", unit_price: 100005, merchant: merchant1) }
  let!(:item5) { Item.create!(name: "Computer Mouse", description: "Moves Cursor", unit_price: 5000, merchant: merchant2) }

  describe 'when I visit the merchant items index page' do
    it 'shows a list of the names of all my items' do
      visit merchant_items_path(merchant1)
      # visit "/merchants/#{merchant1.id}/items"

      expect(page).to have_content(item1.name)
      expect(page).to have_content(item2.name)
      expect(page).to have_content(item3.name)
      expect(page).to have_content(item4.name)
      expect(page).to_not have_content(item5.name)
    end

    it 'has a button to go to the items show page' do
      visit merchant_items_path(merchant1)

      within "#item-#{item1.id}" do
        expect(page).to have_link("#{item1.name}")
      end
      within "#item-#{item2.id}" do
       expect(page).to have_link("#{item2.name}")
      end
      within "#item-#{item3.id}" do
       expect(page).to have_link("#{item3.name}")
      end
      within "#item-#{item4.id}" do
        expect(page).to have_link("#{item4.name}")
      end

      click_link("#{item1.name}")

      expect(current_path).to eq(merchant_item_path(merchant1.id, item1.id))
    end
  end

  describe "When I visit my items index page" do
    it "next to each item name I see a button to enable or disable that item" do
      visit merchant_items_path(merchant1)

      within "#item-#{item1.id}" do
        expect(page).to have_button("Enable")
      end
      within "#item-#{item2.id}" do
       expect(page).to have_button("Enable")
      end
      within "#item-#{item3.id}" do
       expect(page).to have_button("Enable")
      end
      within "#item-#{item4.id}" do
        expect(page).to have_button("Enable")
      end
    end
  end

  describe "When I click this button" do
    it "I am redirected to the items index and I see that the item status has changed" do
      visit merchant_items_path(merchant1)
      
      within "#item-#{item1.id}" do
        expect(page).to have_content("Status: disabled")
        click_button "Enable"
      end  
      
      within "#item-#{item1.id}" do
        expect(page).to have_content("#{item1.name} Status: enabled")
      end
    end
  end
end 