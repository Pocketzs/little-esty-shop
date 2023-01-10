class InvoicesController < ApplicationController
  def update
    invoice = Invoice.find(params[:id])
    
    #update to stronger params?
    invoice.update(status: params[:invoice][:status])
    
    redirect_to admin_invoice_path(params[:id])
  end
end
