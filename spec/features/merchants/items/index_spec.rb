# 11. Merchant Item Create

# As a merchant
# When I visit my items index page
# I see a link to create a new item.
# When I click on the link,
# I am taken to a form that allows me to add item information.
# When I fill out the form I click ‘Submit’
# Then I am taken back to the items index page
# And I see the item I just created displayed in the list of items.
# And I see my item was created with a default status of disabled.

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
  
  describe "when I visit merchant index page" do
    it "I see a link to create a new item" do
      visit merchant_items_path(merchant1)

      expect(page).to have_link("Create New Item")
    end

    it "when I click the link I am taken to a form that allows me to add item information" do
      visit merchant_items_path(merchant1)

      click_link("Create New Item")

      expect(page).to have_current_path("/merchants/#{merchant1.id}/items/new")
# save_and_open_page
      expect(page).to have_field('Name')
      expect(page).to have_field('Description')
      expect(page).to have_field('Current Selling Price')
    end

    it "When I fill out the form and hit 'submit I am taken back to the items index page" do
      visit "/merchants/#{merchant1.id}/items/new"

      fill_in("Name", with: "Bubble Machine")
      fill_in("Description", with: "Serotonin Maker")
      fill_in("Current Selling Price", with: 2500)

      click_button("Save")
require 'pry'; binding.pry
      # expect(page).to have_current_path(merchant_items_path(merchant1))
      # expect(page).to have_content("Name: Bubble Machine")
      # expect(page).to have_content("Description: Serotonin Maker")
      # expect(page).to have_content("Current Selling Price: 2500")
    end

    xit "I see the item I just created in the list of items and a status of disabled" do
      visit merchant_items_path(merchant1)

        within "#index-#{item6.id}" do
          expect(page).to have_content("Status: disabled")
        end
      
    end
  end
end 