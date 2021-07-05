Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :users, only: [:show]
  post '/users/guest_sign_in', to: 'users#guest_sign_in'
  root to: 'tweets#index'

  resources :tweets do
    resources :comments, only: [:create] 
    resources :likes, only: [:create, :destroy]
    collection do
      get 'search'
      get 'search_tag'
      get 'searchIncre_tag'
      get 'search_tags'
    end
  end
end

