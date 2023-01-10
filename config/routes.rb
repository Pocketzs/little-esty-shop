Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :merchants, only: [:index, :show, :update, :edit]
    resources :invoices, only: [:index, :show]
    resources :dashboard, only: [:index]
  end

  resources :merchants, only:[] do
    resources :items, only:[:index, :show, :edit, :update], controller: "merchant_items"
    resources :invoices, except: [:destroy], controller: "merchant_invoices"
  end

  # note that an invoice object is being edited, so I believe it is most RESTful to have this route
    # (same for invoice_item update)
    
  resources :invoices, only:[:update]

  resources :invoice_items, only: [:update]
end
