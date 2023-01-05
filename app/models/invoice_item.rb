class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: ['pending', 'packaged', 'shipped']

  def total_item_price
  end
end
