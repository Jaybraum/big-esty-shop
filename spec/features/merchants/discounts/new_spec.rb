require 'rails_helper'

RSpec.describe 'create discount' do
  before :each do
    @merchant_1 = Merchant.first
  end

  it 'creates a new discount' do
    visit "/merchants/#{@merchant_1.id}/discounts"

    click_button 'New Discount'

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts/new")

    fill_in 'Percentage discount', with: 45
    fill_in 'Quantity threshold', with: 36
    click_on 'Create Discount'

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts")
    expect(page).to have_content('45')
  end
end
