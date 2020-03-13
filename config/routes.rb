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
  resources :items

  resources :payments, only: [:new, :show]
  resources :users, only: [:show]
  
end
