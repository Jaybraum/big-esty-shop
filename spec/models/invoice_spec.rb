require 'rails_helper'

RSpec.describe Invoice do
  before(:each) do
    @merchant = Merchant.create!(name: 'Sally Handmade')
    @merchant_2 = Merchant.create!(name: 'Billy Mandmade')
    @item =  @merchant.items.create!(name: 'Qui Essie', description: 'Lorem ipsim', unit_price: 75107)
    @item_2 =  @merchant.items.create!(name: 'Essie', description: 'Lorem ipsim', unit_price: 75107)
    @item_3 = @merchant_2.items.create!(name: 'Glowfish Markdown', description: 'Lorem ipsim', unit_price: 55542)
    @customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
    @invoice = Invoice.create!(customer_id: @customer.id, status: 'completed')
    @invoice_2 = Invoice.create!(customer_id: @customer.id, status: 'completed')
    InvoiceItem.create!(item_id: @item.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
    InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
    InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
  end

  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :invoice_items}
    it {should have_many :transactions}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'class methods' do
    describe '#filter_by_unshipped_order_by_age' do
      it 'returns all invoices with unshipped items sorted by creation date' do
        expect(Invoice.filter_by_unshipped_order_by_age.count("distinct invoices.id")).to eq(45)
        expect(Invoice.filter_by_unshipped_order_by_age.first.id).to eq(10)
      end
    end
  end

  describe 'instance methods' do
    # Test pulls instance from test db to test against
    it 'has array of available status options' do
      single_invoice = Invoice.last
      expect(single_invoice.statuses).to eq ['in progress', 'completed', 'cancelled']
    end

    it 'calculates total potential revenue' do
      single_invoice = Invoice.last
      total_revenue = single_invoice.invoice_items.total_revenue # utilizes class method from InvoiceItems
      expect(single_invoice.revenue).to eq total_revenue
    end

    it '#total discounted revenue' do
      @merchant = Merchant.create!(name: 'Sally Handmade')

      @disco_1 = @merchant.discounts.create!(percentage_discount: 30, quantity_threshold: 10)
      @disco_2 = @merchant.discounts.create!(percentage_discount: 20, quantity_threshold: 9)
      @disco_3 = @merchant.discounts.create!(percentage_discount: 10, quantity_threshold: 8)

      @item_1 = @merchant.items.create!(name: 'Qui Essie', description: 'Lorem ipsim', unit_price: 10)
      @item_2 =  @merchant.items.create!(name: 'Essie', description: 'Lorem ipsim', unit_price: 10)
      @item_3 = @merchant.items.create!(name: 'Glowfish Markdown', description: 'Lorem ipsim', unit_price: 10)

      @customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')

      @invoice = Invoice.create!(customer_id: @customer.id, status: 'completed')

      @invi_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice.id, quantity: 10, unit_price: 100, status: 1)
      @invi_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice.id, quantity: 9, unit_price: 100, status: 1)
      @invi_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice.id, quantity: 8, unit_price: 100, status: 2)


      expect(@invoice.revenue).to eq(2700)
      expect(@invoice.total_of_discount).to eq(560)
      expect(@invoice.discounted_revenue).to eq(2140)
    end
  end
end
