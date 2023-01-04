require 'rails_helper'

RSpec.describe "Admin Merchants Update" do
  let!(:merchant1) {FactoryBot.create(:merchant)}
  
  describe 'User Story 26' do
    it 'when I visit the admin merchant show page' do
      visit admin_merchant_path(merchant1.id)
      
      expect(page).to have_button('Update')
      click_on 'Update'
      
      expect(current_path).to eq(admin_merchant_path(merchant1.id))
    end
  end
end
# As an admin,
# When I visit a merchant's admin show page
# Then I see a link to update the merchant's information.
# When I click the link
# Then I am taken to a page to edit this merchant
# And I see a form filled in with the existing merchant attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the merchant's admin show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.