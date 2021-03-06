Rails.application.routes.draw do
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:index, :show, :edit, :update] do
    get '/friends', to: 'friendships#index'
    member do
      delete 'delete_image/:image_id', action: 'delete_image', as: 'delete_image'
    end
  end

  resources :posts do
    post 'like', to: 'likes#create'
    delete 'like', to: 'likes#destroy'
    resources :comments, only: [:create, :destroy]
  end

  resources :friendships

  root to: 'static_pages#home'
  
  get '/home', to: 'static_pages#home'
  get '/requests', to: 'static_pages#friend_requests'
end
