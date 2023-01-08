require 'rails_helper'

RSpec.describe "Admin Merchants Index" do
  let!(:merchant1) {FactoryBot.create(:merchant, name: "Jurassic Quark")}
  let!(:merchant2) {FactoryBot.create(:merchant, name: "A Parfait Storm")}
  let!(:merchant3) {FactoryBot.create(:merchant, name:"Fry Hard", status: 1)}
  describe "User Story 26" do
    it "lists merchants in system" do
      # When I visit the admin merchants index (/admin/merchants)
      visit admin_merchants_path
      # Then I see the name of each merchant in the system
      expect(page).to have_content(merchant1.name)
      expect(page).to have_content(merchant2.name)
      expect(page).to have_content(merchant3.name)
    end
  end
  
  describe 'User Story 27' do
    it 'has a button to enable or disable a merchant' do
      # # When I visit the admin merchants index
      visit admin_merchants_path

      # # Then next to each merchant name I see a button to disable or enable that merchant.
      within "#merchant_#{merchant1.id}" do
        expect(page).to have_content('Disabled')
        expect(page).to have_button('Enable')
        # # When I click this button
        click_button 'Enable'
        # # Then I am redirected back to the admin merchants index
        expect(current_path).to eq("/admin/merchants")
        expect(page).to have_content('Enabled')
        expect(page).to have_button('Disable')
      end
      
      within "#merchant_#{merchant2.id}" do
        expect(page).to have_content('Disabled')
        expect(page).to have_button('Enable')
        # # When I click this button
        click_button 'Enable'
        # # Then I am redirected back to the admin merchants index
        expect(current_path).to eq("/admin/merchants")
        expect(page).to have_content('Enabled')
        expect(page).to have_button('Disable')
      end
    end
  end
  
  describe 'User Story 28' do
    describe 'separates merchants by status' do
      it "has an 'Enabled Merchants' section" do
        # # When I visit the admin merchants index
        visit admin_merchants_path
        # # Then I see two sections, one for "Enabled Merchants"
        expect(page).to have_content("Enabled Merchants")
        # # And I see that each Merchant is listed in the appropriate section
        within('#enabled-merchants') do
          expect(page).to_not have_content(merchant1.name)
          expect(page).to_not have_content(merchant2.name)
          expect(page).to have_content(merchant3.name)
        end
      end
      
      it "has an 'Disabled Merchants' section" do
        # # When I visit the admin merchants index
        visit admin_merchants_path
        # # Then I see two sections, one for "Disabled Merchants"
        expect(page).to have_content("Disabled Merchants")
        # # And I see that each Merchant is listed in the appropriate section
        within('#disabled-merchants') do
          expect(page).to have_content(merchant1.name)
          expect(page).to have_content(merchant2.name)
          expect(page).to_not have_content(merchant3.name)
        end
      end
    end
  end
end