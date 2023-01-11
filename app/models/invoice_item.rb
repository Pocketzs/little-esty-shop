class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: ['pending', 'packaged', 'shipped']
  
  def invoice_date
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").order(:created_at).pluck(:invoice_id)
    
    invoice_ids.map do |id|
      Invoice.find(id).created_at
    end
  end
end
