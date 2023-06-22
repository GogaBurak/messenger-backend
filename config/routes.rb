Rails.application.routes.draw do
  post 'signup', to: 'sessions#signup', as: 'signup'
  post 'login', to: 'sessions#login', as: 'login'
  delete 'logout', to: 'sessions#logout', as: 'logout'

  resources :messages, only: [:index]
end
