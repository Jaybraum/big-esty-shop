require 'rails_helper'

RSpec.describe 'invoices index page', type: :feature do
  xdescribe 'page appearance' do
    it 'has links to every invoice' do
      visit '/admin/invoices'

      expect(page).to have_link "invoice-#{invoices(:invoice_1).id}"
      expect(page).to have_link "invoice-#{invoices(:invoice_2).id}"
      expect(page).to have_link "invoice-#{invoices(:invoice_3).id}"
      expect(page).to have_link "invoice-#{invoices(:invoice_4).id}"
      click_link "invoice-#{invoices(:invoice_4).id}"
      expect(current_path).to eq "/admin/invoices/#{invoices(:invoice_4).id}"
    end
  end

  describe 'page functionality' do
  end

  #after :all do
    #@jack_daniels.destroy
    #@isabella.destroy
    #@invoice1.destroy
    #@invoice2.destroy
    #@invoice3.destroy
    #@invoice4.destroy
  #end
end
