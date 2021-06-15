require 'rails_helper'

RSpec.describe DiscountItem do

  describe 'relationships' do
    it {should belong_to :invoice_item}
    it {should belong_to :discount}
  end
end
