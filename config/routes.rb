Rails.application.routes.draw do
  get 'static_pages/home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'static_pages#home'
end
