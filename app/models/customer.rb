class Customer < ApplicationRecord
   has_many :invoices
   has_many :transactions, through: :invoices
   has_many :invoice_items, through: :invoices
   has_many :items, through: :invoice_items
   has_many :merchants, through: :items

   validates_presence_of :first_name, :last_name

   def self.top_five_successful_transactions
    self.joins(:transactions)
        .where("transactions.result = 1")
        .group(:id)
        .order("COUNT(transactions.id) DESC")
        .limit(5)
   end
   
   def count_successful_transactions
    self.transactions.count
   end
end