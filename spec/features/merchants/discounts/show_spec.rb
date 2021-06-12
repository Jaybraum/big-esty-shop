require 'rails_helper'

RSpec.describe 'Merchant discounts show page' do
  before :each do
    @merchant = Merchant.create!(name: 'Sally Handmade')
    @dis_1 = @merchant.discounts.create!(percentage_discount: 5, quantity_threshold: 15)
  end

  it 'displays discount and its attributes' do
    visit "/merchants/#{@merchant.id}/discounts/#{@dis_1.id}"

    expect(page).to have_content(@dis_1.percentage_discount)
    expect(page).to have_content(@dis_1.quantity_threshold)
  end
end
