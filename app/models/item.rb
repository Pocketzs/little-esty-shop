class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  validates_presence_of :name, :description, :unit_price
  validates_numericality_of :unit_price, only_integer: true

  enum status: [:disabled, :enabled]
  
  
  
  def invoice_date
    invoice_id = InvoiceItem.where(item_id:self.id).pluck(:invoice_id).first
    
    Invoice.where(id: invoice_id).first.created_at.strftime("%A, %B %d, %Y")
  end
end
