Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resource :admin, only: :index

  namespace :admin do
    resources :merchants, only: [:index, :show]
    resources :invoices, only: [:index, :show]
  end

  resources :merchants, only:[] do
    resources :items, only:[:index, :show, :edit, :update], controller: "merchant_items"
  end

end
