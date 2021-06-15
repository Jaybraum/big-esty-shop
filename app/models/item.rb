# app/models/item

class Item < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  belongs_to :merchant
  has_many :discounts, through: :merchant
  enum enabled: [:enabled, :disabled]

  def self.not_yet_shipped
    joins(:invoices).select("items.name, invoices.id as invoice_id, invoices.created_at as invoice_date")
    .where.not(invoice_items: {status: "shipped"})
    .order("invoice_date desc")
  end

  def top_day
    invoices
    .joins(:transactions)
    .where("transactions.result = 'success'")
    .select("invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
    .group(:created_at)
    .order("total_revenue desc, created_at desc")
    .first.created_at.to_date
  end
end
