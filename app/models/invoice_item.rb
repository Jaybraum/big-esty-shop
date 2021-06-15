# app/models/invoice_items

class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :discounts, through: :item
  has_many :discount_items
  # enum status: { pending: 0, packaged: 1, shipped: 2 }
  enum status: [:pending, :packaged, :shipped]

  def self.total_revenue
    sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def eligible_discount
    discounts.where('? <= discounts.quantity_threshold', self.quantity)
    .order(discounts: :desc)
    .first
  end

  def discounted_revenue
    self.total_revenue - (self.total_revenue * discount_items)
  end
end
