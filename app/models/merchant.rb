class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name

  def top_five_items_ordered
    self.items
        .joins(:transactions)
        .group(:id)
        .where(transactions: {result: "success"})
        .select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) as revenue")
        .order("revenue desc")
        .limit(5)
  end

  def items_ordered_by_most_recently_updated_at
    self.items.order(updated_at: :desc)
  end
end
