require 'rails_helper'

RSpec.describe 'Merchant Dashboard Index', type: :feature do
  let!(:merchant) { Merchant.create!(name: "Bill's Boardshop") }

  before :each do
    visit "/merchants/#{merchant.id}/dashboard" 
  end

  it 'displays the merchant name' do
    expect(page).to have_content(merchant.name)
  end
end