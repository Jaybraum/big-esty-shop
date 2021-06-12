class Discount < ApplicationRecord
  #has_many :discount_items, dependent: :destroy
  #has_many :items, through: :discount_items
  #has_many :transactions, through: :invoices
  #has_many :customers, through: :invoices
  belongs_to :merchant

end
