Rails.application.routes.draw do
  post 'signup', to: 'users#create', as: 'signup'
  post 'login', to: 'sessions#create', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: [:create]
  resources :sessions

  resources :messages, only: [:index]
end
