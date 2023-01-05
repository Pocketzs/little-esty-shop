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
    if merchant.update!(merchant_params)
      redirect_to admin_merchant_path(merchant.id)
      flash[:notice] = "#{merchant.name} Has Been Updated!"
    else
      # flash[:now] = "Please complete all fields before submitting"
      flash[:alert] = "Please complete all fields before submitting"
    end
  end
  
  private
  
  def merchant_params
    params.require(:merchant).permit(:id, :name)
  end
end