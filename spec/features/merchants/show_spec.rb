# spec/features/merchants/dashboard_spec

require 'rails_helper'

RSpec.describe 'Merchants dashboard show page' do
  describe 'display' do
    before :each do
      @merchant = Merchant.create!(name: 'Sally Handmade')
      @item = @merchant.items.create!(name: 'Qui Essie', description: 'Lorem ipsim', unit_price: 75107)
      @item_2 =  @merchant.items.create!(name: 'Essie', description: 'Lorem ipsim', unit_price: 75107)
      @item_3 = @merchant.items.create!(name: 'Glowfish Markdown', description: 'Lorem ipsim', unit_price: 55542)
      @customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
      @invoice = Invoice.create!(customer_id: @customer.id, status: 'completed')
      InvoiceItem.create!(item_id: @item.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
      InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 2)
    end

    it 'shows name of merchant' do
      visit "/merchants/#{@merchant.id}/dashboard"

      expect(page).to have_content('Sally Handmade')
    end

    it 'links to merchant items index' do
      visit "/merchants/#{@merchant.id}/dashboard"

      click_on 'All Items'

      expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    end

    it 'links to merchant invoices index' do
      visit "/merchants/#{@merchant.id}/dashboard"

      click_on 'All Invoices'

      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
    end

    it 'lists names of all items that are ready to ship' do
      visit "/merchants/#{@merchant.id}/dashboard"

      expect(page).to have_content("Qui Essie")
      expect(page).to have_content("Essie")
      expect(page).to_not have_content("Glowfish")
    end

    it 'lists items by oldest invoice created date' do
      visit "/merchants/#{@merchant.id}/dashboard"

    end

    it 'lists corresponding invoice id of each item' do
      visit "/merchants/#{@merchant.id}/dashboard"

      expect(page).to have_content("##{@invoice.id}")
    end

    it 'links to corresponding merchant invoice show page' do
      visit "/merchants/#{@merchant.id}/dashboard"

      first(:link, "#{@invoice.id}").click

      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice.id}")
    end

    it 'contains a table showing the top 5 customers by successful transactions' do
     customer_2 = Customer.create!(first_name: 'Andrew', last_name: 'Brae')
     customer_3 = Customer.create!(first_name: 'Yaho', last_name: 'Yoo')
     customer_4 = Customer.create!(first_name: 'Sjarn', last_name: 'Max')
     customer_5 = Customer.create!(first_name: 'Blers', last_name: 'Moushca')
     customer_6 = Customer.create!(first_name: 'Knot', last_name: 'Top')

     invoice_2 = Invoice.create!(customer_id: customer_2.id, status: 'completed')
     invoice_3 = Invoice.create!(customer_id: customer_3.id, status: 'completed')
     invoice_4 = Invoice.create!(customer_id: customer_3.id, status: 'completed')
     invoice_5 = Invoice.create!(customer_id: customer_4.id, status: 'completed')
     invoice_6 = Invoice.create!(customer_id: customer_5.id, status: 'completed')
     invoice_7 = Invoice.create!(customer_id: customer_6.id, status: 'completed')

      InvoiceItem.create!(item_id: @item.id, invoice_id: invoice_2.id, quantity: 539, unit_price: 13635, status: 1)
      InvoiceItem.create!(item_id: @item.id, invoice_id: invoice_3.id, quantity: 539, unit_price: 13635, status: 1)
      InvoiceItem.create!(item_id: @item.id, invoice_id: invoice_4.id, quantity: 539, unit_price: 13635, status: 1)
      InvoiceItem.create!(item_id: @item.id, invoice_id: invoice_5.id, quantity: 539, unit_price: 13635, status: 1)
      InvoiceItem.create!(item_id: @item.id, invoice_id: invoice_6.id, quantity: 539, unit_price: 13635, status: 1)

     @invoice.transactions.create!(credit_card_number: 1322556767, credit_card_expiration_date: nil,result: 'success')
     @invoice.transactions.create!(credit_card_number: 1322556768, credit_card_expiration_date: nil,result: 'success')
     @invoice.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')
     invoice_2.transactions.create!(credit_card_number: 1322556767, credit_card_expiration_date: nil,result: 'success')
     invoice_2.transactions.create!(credit_card_number: 1322556768, credit_card_expiration_date: nil,result: 'success')
     invoice_2.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')
     invoice_2.transactions.create!(credit_card_number: 1322556767, credit_card_expiration_date: nil,result: 'success')
     invoice_2.transactions.create!(credit_card_number: 1322556768, credit_card_expiration_date: nil,result: 'success')
     invoice_2.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')
     invoice_3.transactions.create!(credit_card_number: 1322556767, credit_card_expiration_date: nil,result: 'success')
     invoice_3.transactions.create!(credit_card_number: 1322556768, credit_card_expiration_date: nil,result: 'success')
     invoice_3.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')
     invoice_4.transactions.create!(credit_card_number: 1322556767, credit_card_expiration_date: nil,result: 'success')
     invoice_4.transactions.create!(credit_card_number: 1322556768, credit_card_expiration_date: nil,result: 'success')
     invoice_4.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')
     invoice_5.transactions.create!(credit_card_number: 1322556767, credit_card_expiration_date: nil,result: 'success')
     invoice_5.transactions.create!(credit_card_number: 1322556768, credit_card_expiration_date: nil,result: 'success')
     invoice_5.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')
     invoice_6.transactions.create!(credit_card_number: 1322556767, credit_card_expiration_date: nil,result: 'success')
     invoice_6.transactions.create!(credit_card_number: 1322556768, credit_card_expiration_date: nil,result: 'success')
     invoice_6.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')
     invoice_7.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')

      visit "/merchants/#{@merchant.id}/dashboard"

      expect(page).to have_content('Joey Ondricka')
      expect(page).to have_content('Yaho Yoo')
      expect(page).to have_content('Andrew Brae')
      expect(page).to have_content('Blers Moushca')
      expect(page).to have_content('Sjarn Max')
    end

    it 'links to merchant discounts index' do
      visit "/merchants/#{@merchant.id}/dashboard"

      click_on 'All Discounts'

      expect(current_path).to eq("/merchants/#{@merchant.id}/discounts")
    end
  end
end
