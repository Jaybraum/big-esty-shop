require 'rails_helper'

RSpec.describe 'invoices show page', type: :feature do
  before(:all) do
    @invoice = Invoice.first
    @first_invoice_item = @invoice.invoice_items.first
    @last_invoice_item = @invoice.invoice_items.last
  end

  describe 'page appearance' do
    it 'has all info about that invoice' do
      visit "/admin/invoices/#{@invoice.id}"
      date = @invoice.created_at.strftime("%A, %B %d, %Y")
      expect(page).to have_content @invoice.status.capitalize
      expect(page).to have_content @invoice.id
      expect(page).to have_content date
      expect(page).to have_content @invoice.customer.first_name
      expect(page).to have_content @invoice.customer.last_name
    end

    it 'has information about all of the invoice\'s items' do
      visit "/admin/invoices/#{@invoice.id}"
      first_exp_price = "$#{@first_invoice_item.unit_price / 100.0}"
      last_exp_price = "$#{@last_invoice_item.unit_price / 100.0}"
      expect(page).to have_content @first_invoice_item.item.name
      expect(page).to have_content @first_invoice_item.quantity
      expect(page).to have_content first_exp_price
      expect(page).to have_content @first_invoice_item.status.capitalize
      expect(page).to have_content @last_invoice_item.item.name
      expect(page).to have_content @last_invoice_item.quantity
      expect(page).to have_content last_exp_price
      expect(page).to have_content @last_invoice_item.status.capitalize
    end

    it 'lists total revenue from this invoice' do
      visit "/admin/invoices/#{@invoice.id}"
      exp_revenue = "$#{@invoice.revenue / 100.0}"
      within "section#revenue" do
        expect(page).to have_content exp_revenue
      end
    end
  end

  it 'lists total discounted revenue from this invoice' do
    visit "/admin/invoices/#{@invoice.id}"
    exp_revenue = "$#{@invoice.discounted_revenue / 100.0}"
    within "section#revenue" do
      expect(page).to have_content exp_revenue
    end
  end
end

  describe 'page functionality' do
    it 'can update invoice status' do
      visit "/admin/invoices/#{@invoice.id}"
      expected_status = @invoice.status.capitalize
      expect(page).to have_select('invoice_status', selected: expected_status)
      select 'Completed', from: 'invoice_status'
      click_button 'Update Invoice'
      expect(current_path).to eq "/admin/invoices/#{@invoice.id}"
      expect(@invoice.reload.status).to eq 'completed'
    end
  end
end
