Rails.application.routes.draw do
  devise_for :users 
  root to: 'tweets#index'
  post '/users/guest_sign_in', to: 'users#guest_sign_in'
end
