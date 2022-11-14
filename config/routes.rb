Rails.application.routes.draw do
  resources :products, only: [:index, :update]
  resources :baskets, only: [:create]
end
