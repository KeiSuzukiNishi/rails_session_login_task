Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy, :show]
  resources :users, only: [:new, :create, :show]
  resources :users do
    get 'edit', on: :member
  end
  delete '/logout', to: 'sessions#destroy'
end
