# 19. Admin Dashboard

# As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a header indicating that I am on the admin dashboard
require 'rails_helper'

RSpec.describe "Admin Dashboard Index Page" do
  
  describe "when I visit the admin dashboard" do
    it "I see a header that indicates that I am on the admin dashboard" do
      visit admin_dashboard_index_path

      expect(page).to have_content("Admin Dashboard Index Page")
    end
  end
end