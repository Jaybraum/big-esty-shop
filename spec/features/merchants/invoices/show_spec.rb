# spec/features/merchants/invoices/show_spec

require 'rails_helper'

RSpec.describe 'Merchant invoice show page' do
  before :each do
    @merchant = Merchant.create!(name: 'Sally Handmade')

    @disco_1 = @merchant.discounts.create!(percentage_discount: 30, quantity_threshold: 10)
    @disco_2 = @merchant.discounts.create!(percentage_discount: 20, quantity_threshold: 9)
    @disco_3 = @merchant.discounts.create!(percentage_discount: 10, quantity_threshold: 8)

    @item_1 = @merchant.items.create!(name: 'Qui Essie', description: 'Lorem ipsim', unit_price: 10)
    @item_2 =  @merchant.items.create!(name: 'Essie', description: 'Lorem ipsim', unit_price: 10)
    @item_3 = @merchant.items.create!(name: 'Glowfish Markdown', description: 'Lorem ipsim', unit_price: 10)

    @customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')

    @invoice = Invoice.create!(customer_id: @customer.id, status: 'completed')
    @invoice_2 = Invoice.create!(customer_id: @customer.id, status: 'completed')

    @invi_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice.id, quantity: 10, unit_price: 100, status: 1)
    @invi_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice.id, quantity: 9, unit_price: 100, status: 1)
    @invi_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice.id, quantity: 8, unit_price: 100, status: 2)
  end

  describe 'display' do
    it 'shows invoice and its attributes' do
      created_at = @invoice.created_at.strftime('%A, %B %d, %Y')
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

      expect(page).to have_content("INVOICE # #{@invoice.id}")
      expect(page).to_not have_content("INVOICE # #{@invoice_2.id}")
      expect(page).to have_content("#{@invoice.status}")
      expect(page).to have_content("#{created_at}")
    end

    it 'lists all items and item attributes on the invoice' do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

      expect(page).to have_content("Qui Essie")
      expect(page).to have_content("Essie")
      expect(page).to have_content("Essie")
      expect(page).to have_content("Glowfish Markdown")
      expect(page).to have_content("$100.00")
    end

    it 'can update items status through dropdown list' do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

      expect(page).to have_button("Save")

      within first('.status-update') do
        expect(page).to have_content("packaged")

        select "shipped"
        click_on "Save"
      end

      expect(page).to have_content("shipped")
      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice.id}")
    end

    it 'lists total revenue of all items on invoice' do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

      expect(page).to have_content("Expected Total Revenue: $27.00")
    end

    it 'lists total discounted revenue of all items on invoice' do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

      expect(page).to have_content("Expected Revenue With Discount Applied: $21.40")
    end

    it 'links to discount show page' do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"

      within "#invi-#{@invi_1.id}" do
        click_on("30% Discount")
      end

      expect(current_path).to eq(merchant_discount_path(@merchant, @disco_1))
    end
  end
end
