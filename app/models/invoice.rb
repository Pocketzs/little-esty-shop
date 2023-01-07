class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  enum status: ['in progress', 'completed', 'cancelled']


  # def total_revenue(merchant) 
  #   require 'pry'; binding.pry
  #   self.items.where(merchant_id: merchant).sum("invoice_items.quantity * invoice_items.unit_price")
  # end

  def total_revenue
    self.invoice_items.sum("quantity * unit_price")
  end
end

