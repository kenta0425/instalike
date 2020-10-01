Rails.application.routes.draw do
  devise_for :users
  # , skip: :all
  
  # devise_scope :user do
  #   get 'signup', to: 'devise/registrations#new'
  #   post 'signup', to: 'devise/registrations#create'
  #   get 'login', to: 'users/sessions#new'
  #   post 'login', to: 'users/sessions#create'
  #   delete 'logout', to: 'devise/sessions#destroy'
  #   get 'passwordedit', to: 'devise/passwords#edit'
  #   put 'passwordedit', to: 'devise/passwords#update'
  # end
  
  root 'index#home'
  get    '/terms',  to: 'index#terms'
  resources :users do
    member do
      get :following, :followers, :users_posts
    end
  end
  resources :posts do
    resources :comments
    post 'add' => 'likes#create'
    delete '/add' => 'likes#destroy'
  end
  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: [:index, :destroy]
  resources :comments
end
