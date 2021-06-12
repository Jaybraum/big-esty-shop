class Merchants::DiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = Discount.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end
end
