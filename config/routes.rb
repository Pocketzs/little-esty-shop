Rails.application.routes.draw do

  # resource :admin, only: :index

  namespace :admin do
    resources :merchants, only: [:index, :show, :update, :edit]
    resources :invoices, only: [:index, :show, :update]
  end

  resources :merchants, only:[] do
    resources :items, only:[:index, :show, :edit, :update], controller: "merchant_items"
    resources :invoices, except: [:destroy], controller: "merchant_invoices"
  end

  resources :invoices, only:[:update]

  resources :invoice_items, only: [:update]


  get '/merchants/:id/dashboard', to: "merchants#show"
end

