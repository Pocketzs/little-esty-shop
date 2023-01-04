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
    if merchant.update(merchant_params)
      flash.notice = "#{merchant.name} Has Been Updated!"
      redirect_to admin_merchant_path(@merchant)
    else
      flash.notice = "Please complete all fields before submitting"
      redirect_to admin_merchant_path(@merchant)
    end
  end
  
  private
  
  def merchant_params
    params.permit(:id, :name, :updated_at)
  end
end