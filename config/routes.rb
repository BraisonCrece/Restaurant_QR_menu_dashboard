Rails.application.routes.draw do
  root 'products#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get '/control_panel', to: 'products#control_panel'
  post 'toggle_active/:product_id', to: 'products#toggle_active', as: :toggle_active
  resources :allergens
  resources :products
  resources :categories
  post 'translate', to: 'translate#translate'
  post 'describe_dish', to: 'description#describe_dish'
end
