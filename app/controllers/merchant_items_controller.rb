class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    
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

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end


