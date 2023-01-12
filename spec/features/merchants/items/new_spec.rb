require 'rails_helper'

RSpec.describe "merchant items new form" do
  let!(:merchant1) { Merchant.create!(name: "Billy's Butters") }
  it "When I fill out the form and hit 'submit I am taken back to the items index page" do
    visit "/merchants/#{merchant1.id}/items/new"

    fill_in("Name", with: "Bubble Machine")
    fill_in("Description", with: "Serotonin Maker")
    fill_in("Current Selling Price", with: 2500)

    click_button("Submit")

    expect(current_path).to eq(merchant_items_path(merchant1.id))
  end

  it "I see the item I just created in the list of items and a status of disabled" do
    visit "/merchants/#{merchant1.id}/items/new"

    fill_in("Name", with: "Bubble Machine")
    fill_in("Description", with: "Serotonin Maker")
    fill_in("Current Selling Price", with: 2500)

    click_button("Submit")

    item = Item.last
    within "#item_#{item.id}" do
      expect(page).to have_link("Bubble Machine")
      expect(page).to have_content("Status: disabled")
    end

    expect(page).to have_content('Item has been created!')
  end

  describe "If any fields are left blank when creating a new merchant item and
  I click submit" do
    describe "If name is blank" do
      it 'I stay on the merchant item new form page with the form pre filled with any filled in info' do
        visit "/merchants/#{merchant1.id}/items/new"
  
        fill_in("Description", with: "Serotonin Maker")
        fill_in("Current Selling Price", with: 2500)
        click_button("Submit")
  
        expect(page).to have_field("Name", with: "")
        expect(page).to have_field("Description", with: "Serotonin Maker")
        expect(page).to have_field("Current Selling Price", with: 2500)

        expect(page).to have_content("Fields cannot be blank")
      end
    end

    describe "If Description is blank" do
      it 'I stay on the merchant item new form page with the form pre filled with any filled in info' do
        visit "/merchants/#{merchant1.id}/items/new"
        
        fill_in("Name", with: "Bubble Machine")
        fill_in("Current Selling Price", with: 2500)
        click_button("Submit")
  
        expect(page).to have_field("Name", with: "Bubble Machine")
        expect(page).to have_field("Description", with: "")
        expect(page).to have_field("Current Selling Price", with: 2500)

        expect(page).to have_content("Fields cannot be blank")
      end
    end

    describe "If Current Selling Price is blank" do
      it 'I stay on the merchant item new form page with the form pre filled with any filled in info' do
        visit "/merchants/#{merchant1.id}/items/new"
        
        fill_in("Name", with: "Bubble Machine")
        fill_in("Description", with: "Serotonin Maker")
        click_button("Submit")
        
        expect(page).to have_field("Name", with: "Bubble Machine")
        expect(page).to have_field("Description", with: "Serotonin Maker")
        expect(page).to have_field("Current Selling Price", with: "")

        expect(page).to have_content("Fields cannot be blank")
      end
    end

    describe "If all fields are blank" do
      it 'I stay on the merchant item new form page with the form pre filled with any filled in info' do
        visit "/merchants/#{merchant1.id}/items/new"
        
        click_button("Submit")
        
        expect(page).to have_field("Name", with: "")
        expect(page).to have_field("Description", with: "")
        expect(page).to have_field("Current Selling Price", with: "")

        expect(page).to have_content("Fields cannot be blank")
      end
    end

    describe "If I make a second attempt while successfully completing each field" do
      it "The item is created and we are taken back to the merchant items index with the new item present" do
        visit "/merchants/#{merchant1.id}/items/new"
        
        click_button("Submit")

        fill_in("Name", with: "Bubble Machine")
        fill_in("Description", with: "Serotonin Maker")
        fill_in("Current Selling Price", with: 2500)

        click_button("Submit")

        item = Item.last
        within "#item_#{item.id}" do
          expect(page).to have_link("Bubble Machine")
          expect(page).to have_content("Status: disabled")
        end

        expect(page).to have_content('Item has been created!')
      end
    end
  end
end