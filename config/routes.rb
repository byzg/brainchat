Mailchat::Application.routes.draw do
  devise_for :users
  resources :chats, only: [:index, :new, :create, :show] do
    resources :messages, only: [:create]
    get :details, on: :member
  end
  resources :messages, only: [] do
    get :check_email, on: :collection
  end
  resources :user_friend_assignments, only: [:index, :new, :create]
  resources :account_passwords, only: [:new, :create]

  root :to => 'chats#index'
end
