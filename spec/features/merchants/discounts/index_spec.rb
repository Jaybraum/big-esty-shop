require 'rails_helper'

RSpec.describe 'Merchant discounts index page' do
  before :each do
    @merchant = Merchant.create!(name: 'Sally Handmade')
    @dis_1 = @merchant.discounts.create!(percentage_discount: 5, quantity_threshold: 15)
    @dis_2 = @merchant.discounts.create!(percentage_discount: 10, quantity_threshold: 25)
    @dis_3 = @merchant.discounts.create!(percentage_discount: 15, quantity_threshold: 35)
    @dis_4 = @merchant.discounts.create!(percentage_discount: 20, quantity_threshold: 45)
    @dis_5 = @merchant.discounts.create!(percentage_discount: 25, quantity_threshold: 55)
  end

  it 'displays all the bulk discounts and their attributes' do
    visit "/merchants/#{@merchant.id}/discounts"
    save_and_open_page

    expect(page.all(".discount")[0].text).to eq("5% Discount 15 items purchased in bulk")
    expect(page.all(".discount")[1].text).to eq("10% Discount 25 items purchased in bulk")
    expect(page.all(".discount")[2].text).to eq("15% Discount 35 items purchased in bulk")
    expect(page.all(".discount")[3].text).to eq("20% Discount 45 items purchased in bulk")
    expect(page.all(".discount")[4].text).to eq("25% Discount 55 items purchased in bulk")
  end
end
