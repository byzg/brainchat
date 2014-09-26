Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users/registrations"}
  resources :chats, only: [:index, :new, :create, :show] do
    resources :messages, only: [:create]
    get :details, on: :member
  end
  resources :messages, only: [] do
    get :check_email, on: :collection
  end
  resources :user_friend_assignments, only: [:index, :new, :create]
  resources :account_passwords, only: [:new, :create]
  resources :users, only: [:new] do
    post :create_by_another_user, to: 'users#create', on: :collection
  end

  root :to => 'chats#index'
end
