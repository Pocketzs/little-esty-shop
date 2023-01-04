class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items
      # require 'pry'; binding.pry
  end

  def show
  
  end
end


