class InvoicesController < ApplicationController
  def update
    invoice = Invoice.find(params[:id])
    invoice.update(status: params[:invoice][:status])
    
    redirect_to admin_invoice_path(params[:id])
  end
end
