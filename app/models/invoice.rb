class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  enum status: ['in progress', 'completed', 'cancelled']

  def total_revenue
    self.invoice_items.sum("quantity * unit_price")
  end

  def self.invoice_items_pending
    self.joins(:invoice_items)
    .where("invoice_items.status = 0")
    .group(:id)
    .order(:created_at)
  end
end

