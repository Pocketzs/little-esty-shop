require 'rails_helper'

RSpec.describe "Admin Merchants Create" do
  describe 'User Story 29' do
    it 'admin merchant index page has a link to create a new merchant' do
      # # When I visit the admin merchants index
      visit admin_merchant_path
      
      # # I see a link to create a new merchant.
      expect(page).to have_link('New Merchant')
    end
    
    it 'links goes to New Merchant form' do
      visit admin_merchant_path
      
      # # When I click on the link
      click_on 'New Merchant'
      
      expect(current_path).to eq("/admin/merchants/new")
      
    end
    
  # # As an admin,
  # # When I visit the admin merchants index
  # # I see a link to create a new merchant.
  # # When I click on the link,
  # # I am taken to a form that allows me to add merchant information.
  # # When I fill out the form I click ‘Submit’
  # # Then I am taken back to the admin merchants index page
  # # And I see the merchant I just created displayed
  # # And I see my merchant was created with a default status of disabled.
    end
  end
end