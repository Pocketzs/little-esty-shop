require 'rails_helper'

RSpec.describe 'Merchant Dashboard Index', type: :feature do
  let!(:merchant) { Merchant.create!(name: "Bill's Boardshop") }

  before :each do
    visit "/merchants/#{merchant.id}/dashboard" 
  end

  describe 'As a merchant, when I visit my merchant dashboard' do
    it 'displays the merchant name' do #us1
      expect(page).to have_content(merchant.name)
    end

    it 'shows a link to my merchant items index' do #us2
      expect(page).to have_link("Merchant Items Index")
      expect(page).to have_link("Merchant Invoices Index")
    end

    xit 'shows the names of the top 5 customers' do #us3
      # who have conducted the largest number of successful transactions
      # with my merchant and next to each customer name I see the total number of
      # successful transactions they have conducted
    end
  end
end