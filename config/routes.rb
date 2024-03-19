Rails.application.routes.draw do

  get 'users/sign_in', to: redirect('/') # trick in order to match the client QR code with the root path ;)
  root "dynamic_router#call"

  devise_for :users, path: 'admin', path_names: { sign_in: 'sign_in', sign_out: 'sign_out', sign_up: 'sign_up' }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :allergens
  resources :products
  resources :categories
  resources :wines
  resources :wine_types
  resources :wine_origin_denominations, as: :denominations, path: 'denominations'

  resources :settings, only: [:edit, :update]

  get '/control_panel', to: 'products#control_panel'
  get '/wines_control_panel', to: 'wines#control_panel', as: :wines_control_panel
  post 'toggle_active/:product_id', to: 'products#toggle_active', as: :toggle_active
  post 'wine_toggle_active/:wine_id', to: 'wines#toggle_active', as: :wine_toggle_active
  post 'translate', to: 'translate#translate'
  post 'describe_dish', to: 'description#describe_dish'
  get '/menu', to: 'products#menu', as: :menu
  get '/carta', to: 'products#index', as: :carta
  get '/pages_control', to: 'products#pages_control', as: :pages_control
  post '/reload_i18n', to: 'translate#reload_i18n'
end
