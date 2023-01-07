class MerchantInvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_invoices = @merchant.invoices.distinct
  end

  def show
    # require 'pry'; binding.pry
    @invoice = Invoice.find(params[:id])
  end
end
