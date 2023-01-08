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
end
