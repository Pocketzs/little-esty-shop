class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name
  
  enum status: [:disabled, :enabled]

  def self.top_five_by_revenue
    self.joins(:transactions).where(transactions:{result: 1})
        .select(Arel.sql("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as total_revenue"))
        .group(:id).order("total_revenue desc").limit(5)
  end

  def total_revenue
    total = self.transactions.group(:id).where(transactions:{result: 1}).sum("invoice_items.quantity * invoice_items.unit_price")
    total.values.first
  end

  def best_day
    self.transactions.where(transactions:{result:1})
        .select(Arel.sql("invoices.id, invoice_items.id, invoices.created_at, 
          invoice_items.quantity, invoice_items.unit_price"))
        .order(Arel.sql("invoice_items.quantity * invoice_items.unit_price desc")).pluck("invoices.created_at").first
  end
end
