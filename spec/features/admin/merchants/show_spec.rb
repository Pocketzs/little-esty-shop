require 'rails_helper'

RSpec.describe "Admin Merchants Show" do
  let!(:merchant1) {FactoryBot.create(:merchant)}

  describe "User Story 25" do
    it "link from index to show" do
      # When I click on the name of a merchant from the admin merchants index page,
      visit admin_merchants_path
      
      expect(page).to have_link(merchant1.name)
      click_link(merchant1.name)
      # Then I am taken to that merchant's admin show page (/admin/merchants/merchant_id)
      expect(current_path).to eq(admin_merchant_path(merchant1.id))
      # And I see the name of that merchant
      expect(page).to have_content(merchant1.name)
    end
  end
end