require 'rails_helper'

RSpec.describe "Admin Merchants Update" do
  let!(:merchant1) {FactoryBot.create(:merchant)}
  
  describe 'User Story 26' do
    it 'admin merchant show page has an update button' do
      # # When I visit a merchant's admin show page
      visit admin_merchant_path(merchant1.id)
      
      # # Then I see a link to update the merchant's information.
      expect(page).to have_link("Update #{merchant1.name}")
      click_on "Update #{merchant1.name}"
      
      # # Then I am taken to a page to edit this merchant
      expect(current_path).to eq("/admin/merchants/#{merchant1.id}/edit")
    end
    
    it 'can edit the merchant information' do
      visit "/admin/merchants/#{merchant1.id}/edit"

      # # And I see a form filled in with the existing merchant attribute information
      # expect(page).to have_field()#that's filled in with the existing data)
      
      expect(page).to have_button("Update Merchant")
      fill_in 'Name', with: 'Kiwi Style Tile'
      
      # # When I update the information in the form and I click ‘submit’
      click_button "Update Merchant"
      
      # # Then I am redirected back to the merchant's admin show page where I see the updated information
      expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
      expect(page).to have_content("Kiwi Style Tile")
      # # And I see a flash message stating that the information has been successfully updated.
      expect(page).to have_content("Kiwi Style Tile Has Been Updated!")
    end
  end
end



