require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should have_many(:invoice_items).through(:invoice) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    # Add length validation to integer?
    it { should validate_numericality_of(:credit_card_number) }
  end
end