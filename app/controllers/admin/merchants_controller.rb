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
      redirect_to admin_merchant_path
      flash[:notice] = "#{merchant.name} Has Been Updated!"
    else
      redirect_to admin_merchant_path
    end
  end
  
  private
  
  def merchant_params
    params.require(:merchant).permit(:id, :name)
  end
end