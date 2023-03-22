Rails.application.routes.draw do
  resources :products, only: [:index, :new]
  root 'products#index'
end
