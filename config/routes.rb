Rails.application.routes.draw do
  devise_for :users
  get 'users/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'items#index'
  resources :items do
    collection do
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
      get 'search', defaults: { format: 'json' }
    end
  end
  resources :categories, only: [:index, :show, :new]
  
  resources :payments, only: [:new, :show]
  resources :users, only: [:show]
  
end
