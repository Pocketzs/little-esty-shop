class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  enum status: ['in progress', 'completed', 'cancelled']

  def total_revenue
    invoices = Invoice.joins(:invoice_items)
                      .select("invoices.id, 
                       SUM(invoice_items.quantity * invoice_items.unit_price) 
                       AS total")
                      .group("invoices.id")
                      .where("invoices.id = #{self.id}")

    invoices.first.total
  end

  def self.invoice_items_pending
    self.joins(:invoice_items).where("invoice_items.status = 0").group(:id)
  end
end
