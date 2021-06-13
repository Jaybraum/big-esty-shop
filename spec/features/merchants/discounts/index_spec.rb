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

    expect(page.all(".discount")[0].text).to eq("5% Discount 15 items")
    expect(page.all(".discount")[1].text).to eq("10% Discount 25 items")
    expect(page.all(".discount")[2].text).to eq("15% Discount 35 items")
    expect(page.all(".discount")[3].text).to eq("20% Discount 45 items")
    expect(page.all(".discount")[4].text).to eq("25% Discount 55 items")
  end

  it 'links to discounts show page' do
    visit "/merchants/#{@merchant.id}/discounts"

    click_on "#{@dis_1.percentage_discount}"

    expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/#{@dis_1.id}")
  end

  it 'has a button to create a new item' do
    visit "/merchants/#{@merchant.id}/discounts"

    click_button 'New Discount'

    expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/new")
  end

  it 'has buttons to delete each discount' do
    visit "/merchants/#{@merchant.id}/discounts"

    within "tr#div-#{@dis_1.id}" do
      click_button 'Delete'
    end

    expect(current_path).to eq("/merchants/#{@merchant.id}/discounts")
    expect(page).to_not have_content("5% Discount 15 items purchased in bulk")
  end

  it 'Lists the next three public holidays USA' do
    visit "/merchants/#{@merchant.id}/discounts"

    expect(page).to have_content("Upcoming Holidays")
    #dynamic test fir list
  end
end
