require 'rails_helper'

RSpec.describe 'Merchant Dashboard Index', type: :feature do
  let!(:merchant) { name: "Bill's Boardshop"  }

  before :each do
    visit merchant_dashboard_path(merchant.id)
  end

  it 'displays the merchant name' do
    expect(page).to have_content(merchant.name)
  end
end