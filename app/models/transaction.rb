class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :invoice_items, through: :invoice 
  has_many :items, through: :invoice_items

  validates_numericality_of :credit_card_number, length: { is: 16 }

  enum result: ['failed', 'success']
end
