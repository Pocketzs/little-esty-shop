Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resource :admin, only: :index

  namespace :admin do
<<<<<<< HEAD
    resources :merchants, only: [:index, :show, :update, :edit]
    resources :invoices, only: [:index, :show]
    resources :dashboard, only: [:index]
  end

  resources :merchants, only:[] do
    resources :items, only:[:index, :show, :edit, :update], controller: "merchant_items"
    resources :invoices, except: [:destroy], controller: "merchant_invoices"
=======
    # resources :merchants, except: [:new, :create, :destroy]
    resources :merchants, only: [:index, :show, :update, :edit, :new, :create]
>>>>>>> admin-merchants-grouped
  end

  resources :invoices, only:[:update]

  resources :invoice_items, only: [:update]
end
