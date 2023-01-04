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
  it 'I see a form filled in with the existing item attribute information' do
    visit edit_merchant_item_path(merchant1, item1)

    expect(page).to have_field('Name', with: "#{item1.name}")
    expect(page).to have_field('Description', with: "#{item1.description}")
    expect(page).to have_field('Current Selling Price', with: "#{item1.unit_price}")
    save_and_open_page
  end
end