require 'rails_helper'

RSpec.describe "Admin Merchants Create" do
  describe 'User Story 29' do
    it 'admin merchant index page has a link to create a new merchant' do
      # # When I visit the admin merchants index
      visit admin_merchants_path
      
      # # I see a link to create a new merchant.
      expect(page).to have_link('New Merchant')
    end
    
    it 'links goes to New Merchant form' do
      visit admin_merchants_path
      
      # # When I click on the link
      click_link 'New Merchant'
      
      # # I am taken to a form that allows me to add merchant information.
      expect(current_path).to eq("/admin/merchants/new")
      expect(page).to have_field('Name')
      expect(page).to have_button('Create Merchant')
    end
    
    it 'can be filled in and submitted' do
      visit new_admin_merchant_path
      
      # # When I fill out the form I click ‘Submit’
      fill_in 'Name', with: 'Everything Topsy Turvy'
      click_button 'Create Merchant'
      
      # # Then I am taken back to the admin merchants index page
      expect(current_path).to eq("/admin/merchants")
      # # And I see the merchant I just created displayed
      expect(page).to have_content('Everything Topsy Turvy')
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