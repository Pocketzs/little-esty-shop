Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :merchants, only:[] do
    resources :items, only:[:index, :show, :edit, :update], controller: "merchant_items"
  end
end
