class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: ['pending', 'packaged', 'shipped']
  
  def invoice_date
    invoice.created_at
  end
end
