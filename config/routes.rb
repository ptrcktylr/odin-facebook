Rails.application.routes.draw do
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:index, :show, :edit, :update] do
    get '/friends', to: 'friendships#index'
  end

  resources :posts do
    post 'like', to: 'likes#create'
    delete 'like', to: 'likes#destroy'
  end

  resources :friendships

  root to: 'static_pages#home'
  
  get '/home', to: 'static_pages#home'
  get '/requests', to: 'static_pages#friend_requests'
end
