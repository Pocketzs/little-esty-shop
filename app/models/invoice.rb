class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  enum status: ['in progress', 'completed', 'cancelled']

  def total_revenue
    # Active Record method for:
    # SELECT invoices.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue
    # FROM invoices
    # INNER JOIN invoice_items.invoice_id=invoices.id
    # GROUP BY invoices.id
    invoices = Invoice.joins(:invoice_items).select("invoices.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS total").group("invoices.id").where("invoices.id = #{self.id}")
    invoices.first.total
  end
end
