class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.distinct
  end

  def show
    @merchant_invoice = Invoice.find(params[:id])
  end

  private

  def merchant_invoice_params
    params.permit(:status)
  end
end
