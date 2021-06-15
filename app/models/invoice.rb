# app/models/invoice

class Invoice < ApplicationRecord
  enum status: [ 'in progress', :completed, :cancelled ] # 0 => in progress, 1 => completed, etc
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  def self.filter_by_unshipped_order_by_age
    joins(:invoice_items)
    .distinct.select("invoices.id, invoices.created_at")
    .where.not(invoice_items: {status: 'shipped'})
    .order(:created_at)
  end

  def statuses
    ['in progress', 'completed', 'cancelled']
  end

  # Utilizes class method from InvoiceItems
  def revenue
    invoice_items.total_revenue
  end


end
