Rails.application.routes.draw do
  devise_for :users
  get 'users/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'items#index'
  resources :items
  resources :users, only: [:show]
  # resources :payment, only [:new]
end