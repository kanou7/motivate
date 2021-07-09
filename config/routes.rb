Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :users, only: [:show] do
    member do
      get :likes
    end
  end
  post '/users/guest_sign_in', to: 'users#guest_sign_in'
  root to: 'tweets#index'

  resources :tweets do
    collection do
      get 'search'
      get 'search_tag'
      get 'search_incre_tag'
      get 'search_tags'
      get 'search_status'
      get 'search_job'
    end
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy] 
  end
end

