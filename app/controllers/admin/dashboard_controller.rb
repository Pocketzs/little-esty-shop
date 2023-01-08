class Admin::DashboardController < ApplicationController
  def index
    @incomplete_invoices = Invoice.invoice_items_pending
    @top_customers = Customer.top_five_successful_transactions
  end
end