class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items
      # require 'pry'; binding.pry
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    # require 'pry'; binding.pry
    item = Item.find(params[:id])
    # binding.pry
    if params[:status]
      item.update(status: params[:status])
      redirect_to merchant_items_path(item.merchant_id, item.id)
    elsif item.update(item_params)
      redirect_to merchant_item_path(item.merchant_id, item.id)
      flash[:alert] = 'Item has been updated!'
    else
      redirect_to edit_merchant_item_path(item.merchant_id, item.id)
      flash[:alert] = "Fields cannot be blank"
    end
  end

  def new
  end

  def create
    item_new = Merchant.find(params:[:merchant_id])
    item_new.items.create(item_params)
    redirect_to merchant_item_path(@merchant)
  
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end


end


