class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :merchants, through: :items
  has_many :customers, through: :invoices

  enum status: ['pending', 'packaged', 'shipped']
end
