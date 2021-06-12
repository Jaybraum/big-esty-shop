require 'rails_helper'

RSpec.describe 'updates discount' do
  before :each do
    @merchant = Merchant.create!(name: 'Sally Handmade')
    @dis_1 = @merchant.discounts.create!(percentage_discount: 5, quantity_threshold: 15)
  end

  it 'can update the discount' do
    visit "/merchants/#{@merchant.id}/discounts/#{@dis_1.id}"

    click_link 'Update Discount'

    expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/#{@dis_1.id}/edit")

    fill_in 'Percentage discount', with: 45
    fill_in 'Quantity threshold', with: 36
    click_on 'Update Discount'

    expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/#{@dis_1.id}")
    expect(page).to have_content('45')
  end
end
