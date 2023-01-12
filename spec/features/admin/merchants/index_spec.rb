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
  
  describe "User Story 30 and 31" do
    let!(:merchant4) {create(:merchant)}
    let!(:merchant5) {create(:merchant)}
    let!(:merchant6) {create(:merchant)}
    let!(:customer) {create(:customer)}

    let!(:item1) {create(:item, merchant_id: merchant1.id)}
    let!(:item2) {create(:item, merchant_id: merchant2.id)}
    let!(:item3) {create(:item, merchant_id: merchant3.id)}
    let!(:item4) {create(:item, merchant_id: merchant4.id)}
    let!(:item5) {create(:item, merchant_id: merchant5.id)}
    let!(:item6) {create(:item, merchant_id: merchant6.id)}

    let!(:invoice1) {create(:invoice, customer_id: customer.id)}
    let!(:invoice2) {create(:invoice, customer_id: customer.id)}
    let!(:invoice3) {create(:invoice, customer_id: customer.id)}
    let!(:invoice4) {create(:invoice, customer_id: customer.id)}
    let!(:invoice5) {create(:invoice, customer_id: customer.id)}
    let!(:invoice6) {create(:invoice, customer_id: customer.id)}

    let!(:invoice_item1) {create(:invoice_item, invoice_id: invoice1.id, item_id:item1.id, quantity: 1, unit_price: 100)}
    let!(:invoice_item2) {create(:invoice_item, invoice_id: invoice2.id, item_id:item2.id, quantity: 1, unit_price: 200)}
    let!(:invoice_item3) {create(:invoice_item, invoice_id: invoice3.id, item_id:item3.id, quantity: 1, unit_price: 300)}
    let!(:invoice_item4) {create(:invoice_item, invoice_id: invoice4.id, item_id:item4.id, quantity: 1, unit_price: 400)}
    let!(:invoice_item5) {create(:invoice_item, invoice_id: invoice5.id, item_id:item5.id, quantity: 1, unit_price: 500)}
    let!(:invoice_item6) {create(:invoice_item, invoice_id: invoice6.id, item_id:item6.id, quantity: 1, unit_price: 600)}

    let!(:transaction1) {create(:transaction, invoice_id: invoice1.id, result: 1)}
    let!(:transaction2) {create(:transaction, invoice_id: invoice2.id, result: 1)}
    let!(:transaction3) {create(:transaction, invoice_id: invoice3.id, result: 1)}
    let!(:transaction4) {create(:transaction, invoice_id: invoice4.id, result: 1)}
    let!(:transaction5) {create(:transaction, invoice_id: invoice5.id, result: 1)}
    let!(:transaction6) {create(:transaction, invoice_id: invoice6.id, result: 1)}

    it "top 5 merchants by revenue" do
      # As an admin,
      # When I visit the admin merchants index
      visit admin_merchants_path
    
      within("#top_merchants") do
        # Then I see the names of the top 5 merchants by total revenue generated
        expect(page).to have_content(merchant2.name)
        expect(page).to have_content(merchant3.name)
        expect(page).to have_content(merchant4.name)
        expect(page).to have_content(merchant5.name)
        expect(page).to have_content(merchant6.name)

        expect(page).to_not have_content(merchant1.name)
        
        expect(merchant6.name).to appear_before(merchant5.name)
        expect(merchant5.name).to appear_before(merchant4.name)
        expect(merchant4.name).to appear_before(merchant3.name)
        expect(merchant3.name).to appear_before(merchant2.name)
        
        
        # And I see that each merchant name links to the admin merchant show page for that merchant
        click_link(merchant6.name)
        expect(current_path).to eq admin_merchant_path(merchant6.id)
        
        
      end
    end
    
    it "top 5 merchants display total revenue" do
      visit admin_merchants_path
      
      within("#top_merchants") do
        # And I see the total revenue generated next to each merchant name
        expect(page).to have_content(merchant2.total_revenue / 100.00)
        expect(page).to have_content(merchant3.total_revenue / 100.00)
        expect(page).to have_content(merchant4.total_revenue / 100.00)
        expect(page).to have_content(merchant5.total_revenue / 100.00)
        expect(page).to have_content(merchant6.total_revenue / 100.00)
        # Notes on Revenue Calculation:
        # Only invoices with at least one successful transaction should count towards revenue
        # Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
        # Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
      end
    end
  
    it "best day for top merchant" do
      visit admin_merchants_path
      within("#top_merchants") do
        expect(page).to have_content("Top day for #{merchant6.name} was #{merchant6.best_day.strftime("%A, %B %m, %Y")}")
        expect(page).to have_content("Top day for #{merchant5.name} was #{merchant5.best_day.strftime("%A, %B %m, %Y")}")
        expect(page).to have_content("Top day for #{merchant4.name} was #{merchant4.best_day.strftime("%A, %B %m, %Y")}")
        expect(page).to have_content("Top day for #{merchant3.name} was #{merchant3.best_day.strftime("%A, %B %m, %Y")}")
      end
    end

  end
end