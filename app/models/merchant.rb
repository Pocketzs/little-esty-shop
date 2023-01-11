class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  validates_presence_of :name
  
  enum status: [:disabled, :enabled]

  def self.top_five_by_revenue
    require 'pry'; binding.pry
  end
end
