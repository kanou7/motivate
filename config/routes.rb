Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :users, only: [:show]
  root to: 'tweets#index'
  post '/users/guest_sign_in', to: 'users#guest_sign_in'
end
