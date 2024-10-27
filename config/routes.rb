# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/sign_in', to: redirect('/')
  root 'dynamic_router#call'

  devise_for :users, path: 'admin', path_names: { sign_in: 'sign_in', sign_out: 'sign_out', sign_up: 'sign_up' }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :allergens
  resources :products
  resources :special_menus
  resources :categories
  resources :wines
  resources :wine_types
  resources :wine_origin_denominations, as: :denominations, path: 'denominations'

  resources :settings, only: %i[edit update]

  get '/control_panel', to: 'products#control_panel'
  get '/wines_control_panel', to: 'wines#control_panel', as: :wines_control_panel
  post 'toggle_active/:product_id', to: 'products#toggle_active', as: :toggle_active
  post 'wine_toggle_active/:wine_id', to: 'wines#toggle_active', as: :wine_toggle_active
  post 'toggle_special_menu/:special_menu_id', to: 'special_menus#toggle_active', as: :toggle_special_menu
  post 'translate', to: 'translate#translate'
  post 'describe_dish', to: 'description#describe_dish'
  get '/menu', to: 'products#menu', as: :menu
  get '/carta', to: 'products#index', as: :carta
  get '/pages_control', to: 'products#pages_control', as: :pages_control
  post '/reload_i18n', to: 'translate#reload_i18n'

  # Special menu products
  get '/special_menu/:special_menu_id/new_product', to: 'special_menus#new_product', as: :new_special_menu_product
  post '/special_menu/:special_menu_id/create_product', to: 'special_menus#create_product', as: :create_special_menu_product
  get '/special_menu/:special_menu_id/edit_product/:product_id', to: 'special_menus#edit_product', as: :edit_special_menu_product
  patch '/special_menu/:special_menu_id/update_product/:product_id', to: 'special_menus#update_product', as: :update_special_menu_product
  delete '/special_menu/:special_menu_id/destroy_product/:product_id', to: 'special_menus#destroy_product', as: :destroy_special_menu_product
end
