Rails.application.routes.draw do
  
  namespace :admin do
    resources :merchants, except: [:destroy]
    resources :invoices, only: [:index, :show]
    resources :dashboard, only: [:index]
  end

  resources :merchants, only:[] do
    resources :items, except: [:destroy], controller: "merchant_items"
    resources :invoices, except: [:destroy], controller: "merchant_invoices"
    resources :dashboard, only: [:index], controller: "merchants"
  end

  # note that an invoice object is being edited, so I believe it is most RESTful to have this route
    # (same for invoice_item update)
    
  resources :invoices, only:[:update]
  resources :invoice_items, only: [:update]
end

