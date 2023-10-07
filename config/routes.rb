Rails.application.routes.draw do
  resources :wine_types
  root to: redirect("/#{Setting.root_page}")
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :allergens
  resources :products
  resources :categories
  resources :wines
  resources :wine_origin_denominations, as: :denominations, path: 'denominations'
  get '/control_panel', to: 'products#control_panel'
  get '/wines_control_panel', to: 'wines#control_panel', as: :wines_control_panel
  post 'toggle_active/:product_id', to: 'products#toggle_active', as: :toggle_active
  post 'wine_toggle_active/:wine_id', to: 'wines#toggle_active', as: :wine_toggle_active
  post 'translate', to: 'translate#translate'
  post 'describe_dish', to: 'description#describe_dish'
  get '/menu', to: 'products#menu', as: :menu
  get '/carta', to: 'products#index', as: :carta
  get '/pages_control', to: 'products#pages_control', as: :pages_control
  resources :settings, only: [:edit, :update]
end
