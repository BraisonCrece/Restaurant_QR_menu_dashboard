Rails.application.routes.draw do
  root 'products#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :allergens
  resources :products
end
