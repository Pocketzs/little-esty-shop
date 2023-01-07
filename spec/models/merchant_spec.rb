require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items } 
  end

  describe 'validations' do
    it { should validate_presence_of :name } 
    it { should define_enum_for(:status) } 
  end
end
