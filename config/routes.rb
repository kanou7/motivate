Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :users, only: [:show]
  post '/users/guest_sign_in', to: 'users#guest_sign_in'
  root to: 'tweets#index'
  resources :tweets, only: [:index, :new, :create]
end
