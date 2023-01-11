class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name
  
  enum status: [:disabled, :enabled]

  def self.top_five_by_revenue
    self.joins(:transactions).where(transactions:{result: 1})
        .select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as total_revenue")
        .group(:id).order("total_revenue desc")
  end
end
