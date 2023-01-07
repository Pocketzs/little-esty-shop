class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name

  def enabled_items
    self.items.where(status: "enabled")
  end

  def disabled_items
    self.items.where(status: "disabled")
  end
end
