class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items
      # require 'pry'; binding.pry
  end

  def show
    @item = Item.find_by(merchant_id: params[:merchant_id])
  end

  def edit
    @item = Item.find_by(merchant_id: params[:merchant_id])
  end
end


