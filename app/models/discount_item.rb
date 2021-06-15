class DiscountItem < ApplicationRecord
  belongs_to :invoice_item
  belongs_to :discount
end
