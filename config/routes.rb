Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'user_detail', to: 'users/registrations#new_user_detail'
    post 'user_detail', to: 'users/registrations#create_user_detail'
  end
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
      get  'purchase/:id'=>  'items#purchase', as: 'purchase'
      post 'pay/:id'=>   'items#pay', as: 'pay'
      get  'done'=>      'items#done', as: 'done'

  resources :users, only: [:show]
  resources :credit_cards, only: [:new, :index, :create, :destroy]
  resources :payments, only: [:new, :show]
end
