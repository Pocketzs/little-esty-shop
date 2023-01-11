require 'rails_helper'

RSpec.describe 'The Merchant Items Show page', type: :feature do
  let!(:merchant1) { Merchant.create!(name: "Billy's Butters") }

  let!(:item1) { Item.create!(name: "Tissues", description: "Wipes Nose", unit_price: 1000, merchant: merchant1) }
  let!(:item2) { Item.create!(name: "Apples", description: "Delicious", unit_price: 1200, merchant: merchant1) }
  
  it 'I see a form filled in with the existing item attribute information' do
    visit edit_merchant_item_path(merchant1, item1)

    expect(page).to have_field('Name', with: "#{item1.name}")
    expect(page).to have_field('Description', with: "#{item1.description}")
    expect(page).to have_field('Current Selling Price', with: "#{item1.unit_price}")
  end

  describe 'When I update the info in the form and I click "submit"' do
    it 'I am redirected back to the item show page where I see the updated info' do
      visit edit_merchant_item_path(merchant1, item1)

      fill_in("Name", with: "Ipad")
      fill_in("Description", with: "Tablet for work")
      fill_in("Current Selling Price", with: 10000)
      click_button('Update Item')
      expect(page).to have_current_path(merchant_item_path(merchant1, item1))
      expect(page).to have_content("Name: Ipad")
      expect(page).to have_content("Description: Tablet for work")
      expect(page).to have_content("Current Selling Price: 10000")
    end

    it 'I see a flash message stating that the information has been successfully updated' do
      visit edit_merchant_item_path(merchant1, item1)

      fill_in("Name", with: "Ipad")
      fill_in("Description", with: "Tablet for work")
      fill_in("Current Selling Price", with: 10000)
      click_button('Update Item')

      expect(page).to have_content('Item has been updated!')
    end
  end

  describe 'When I update the info in the form with blank fields and click submit' do
    it 'I stay on the edit form page and I see a flash message to fill in all fields' do
      visit edit_merchant_item_path(merchant1, item1)
      fill_in("Name", with: "")
      fill_in("Description", with: "")
      fill_in("Current Selling Price", with: "")
      click_button('Update Item')

      expect(page).to have_current_path(edit_merchant_item_path(merchant1, item1))
      expect(page).to have_content("Fields cannot be blank")
    end
  end
end