Rails.application.routes.draw do
  
  namespace :admin do
    resources :merchants, only: [:index, :show, :update, :edit]
    resources :invoices, only: [:index, :show]
    resources :dashboard, only: [:index]
  end

  resources :merchants, only:[] do
    resources :items, except: [:destroy], controller: "merchant_items"
    resources :invoices, except: [:destroy], controller: "merchant_invoices"
    resources :dashboard, only: [:index], controller: "merchants"
  end

  resources :invoices, only:[:update]
  resources :invoice_items, only: [:update]
end

