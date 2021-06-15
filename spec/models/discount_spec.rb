require 'rails_helper'

RSpec.describe Discount do

  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many(:items).through(:merchant)}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:merchant)}

  end
end
