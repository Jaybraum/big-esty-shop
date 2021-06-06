# app/models/item

class Item < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  belongs_to :merchant
  enum enabled: [:enabled, :disabled]

  def self.not_yet_shipped
    joins(:invoices).select("items.name, invoices.id as invoice_id, invoices.created_at as invoice_date").where.not('invoice_items.status = 2').order("invoice_date")
  end
end
