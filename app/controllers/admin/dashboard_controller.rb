class Admin::DashboardController < ApplicationController
  def index
    @incomplete_invoices = Invoice.invoice_items_pending
  end
end