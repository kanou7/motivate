Rails.application.routes.draw do
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :users, only: [:show]
  root to: 'tweets#index'

  resources :tweets do
    resources :comments, only: [:create] 
    resources :likes, only: [:create, :destroy]
  end
end

