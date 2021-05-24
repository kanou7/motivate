Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :users, only: [:show]
  post '/users/guest_sign_in', to: 'users#guest_sign_in'
  root to: 'tweets#index'
  resources :tweets do
    resources :comments, only: :create
    post 'add' => 'likes#create'
    delete '/add' => 'likes#destroy'
  end
end
