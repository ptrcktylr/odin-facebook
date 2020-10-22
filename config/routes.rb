Rails.application.routes.draw do
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:index, :show, :edit, :update]

  root to: 'static_pages#home'
  
  get '/home', to: 'static_pages#home'
end
