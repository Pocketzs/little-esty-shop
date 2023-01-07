# 20. Admin Dashboard Links

# As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a link to the admin merchants index (/admin/merchants)
# And I see a link to the admin invoices index (/admin/invoices)

require 'rails_helper'

RSpec.describe "Admin Dashboard Index Page" do
  
  describe "when I visit the admin dashboard" do
    it "I see a header that indicates that I am on the admin dashboard" do #us 19
      visit admin_dashboard_index_path

      expect(page).to have_content("Admin Dashboard Index Page")
    end
  end

  describe "when I visit the admin dashboard" do
    it "I see a link to the admin merchants index" do #us 20
      visit admin_dashboard_index_path

      expect(page).to have_link("Admin Merchant Index")
    end
  end

    it "I see a link to the admin invoices index" do
      visit admin_dashboard_index_path

      expect(page).to have_link("Admin Invoice Index")
    end
end