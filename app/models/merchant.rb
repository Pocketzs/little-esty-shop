class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name
  
  enum status: [:disabled, :enabled]
end
