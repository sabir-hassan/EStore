Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'categories#index'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :cart, only: [:index, :create, :destroy]
      resources :order, only: [:create]
      resources :categories, only: [:index] do
        resources :products, only: [:index]
      end
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
      end
    end
  end
  


  post '/search', to: 'products#index'

  devise_scope :user do
    get '/users/sign_out', to:'devise/sessions#destroy'
  end

#  ActiveAdmin.routes(self)

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
 
  resources :categories, only: [:index] do
    resources :products, only: [:index]
  end

  resources :order_items, path: 'cart/items'
  resources :static

  get '/cart', to: 'order_items#index'
  
  get '/cart/checkout', to: 'orders#new', as: :checkout
  
  patch '/cart/checkout', to: 'orders#create'
end
