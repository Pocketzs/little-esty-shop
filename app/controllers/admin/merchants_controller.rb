class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
  
  def edit
    @merchant = Merchant.find(params[:id])
  end
  
  def update
    merchant = Merchant.find(params[:id])
  end
  
  private
  
  def merchant_params
    params.permit(:id, :name, :updated_at)
  end
  
  # id,name,created_at,updated_at
  
end