class Discount < ApplicationRecord
  belongs_to :merchant
  has_many :discount_items
  has_many :invoice_items, through: :discount_items
end
