require 'rails_helper'

RSpec.describe InvoiceItem do

  describe 'relationships' do
    it {should belong_to :invoice}
    it {should belong_to :item}
  end

  describe 'class methods' do
    describe '.total_revenue' do
      it 'returns expected total revenue of all invoice items' do

        expect(InvoiceItem.total_revenue).to eq(60481323)
      end
    end
  end

  describe 'instance methods' do
    describe '.eligible_for_discount' do
      it 'returns the highest percentage discount' do
        @merchant = Merchant.create!(name: 'Sally Handmade')
        @item_1 = @merchant.items.create!(name: 'Qui Essie', description: 'Lorem ipsim', unit_price: 75107)
        @item_2 =  @merchant.items.create!(name: 'Essie', description: 'Lorem ipsim', unit_price: 75107)
        @item_3 = @merchant.items.create!(name: 'Glowfish Markdown', description: 'Lorem ipsim', unit_price: 55542)
        @customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
        @invoice = Invoice.create!(customer_id: @customer.id, status: 'completed')
        @invi_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice.id, quantity: 10, unit_price: 13635, status: 1)
        @invi_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice.id, quantity: 9, unit_price: 13635, status: 1)
        @invi_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice.id, quantity: 8, unit_price: 13635, status: 2)
        @disco_1 = @merchant.discounts.create!(percentage_discount: 10, quantity_threshold: 10)
        @disco_2 = @merchant.discounts.create!(percentage_discount: 5, quantity_threshold: 9)
        @disco_3 = @merchant.discounts.create!(percentage_discount: 2, quantity_threshold: 8)

        expect(@invi_1.eligible_discount).to eq(@disco_1)
        expect(@invi_2.eligible_discount).to eq(@disco_2)
        expect(@invi_3.eligible_discount).to eq(@disco_3)
      end
    end
  end
end
