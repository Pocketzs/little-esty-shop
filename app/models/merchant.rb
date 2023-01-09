class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  validates_presence_of :name


  def top_customers
    
    self.customers
    .joins(:transactions)
    .where(transactions: {result: 1} )
    .select("customers.*, count(transactions.id) as successful_transactions")
    .group(:id).order("successful_transactions DESC").limit(5)
  end
end
