class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items_ordered_by_most_recently_updated_at
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
      redirect_to merchant_items_path(item.merchant_id)
    elsif item.update(item_params)
      redirect_to merchant_item_path(item.merchant_id, item.id)
      flash[:alert] = 'Item has been updated!'
    else
      redirect_to edit_merchant_item_path(item.merchant_id, item.id)
      flash[:alert] = "Fields cannot be blank"
    end
  end

  def new
    @item = Item.new(merchant_id: params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.new(item_params)
    if item.save
      redirect_to merchant_items_path(merchant.id)
      flash[:notice] = 'Item has been created!'
    else
      flash[:alert] = "Fields cannot be blank"
      @item = merchant.items.new(item_params)
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end


