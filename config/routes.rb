Rails.application.routes.draw do
  get 'notes/index'
  get 'notes/new'
  get 'notes/create'
  get 'notes/edit'
  get 'notes/update'
  get 'notes/destroy'
  get 'users/show'
  authenticated :user do
    root to: "subjects#index"
  end

  resources :subjects do
    resources :class_memberships, only: [:create]
    resources :users, only: [:show] do
      resources :appointments, only: [:create]
    end
  end

  resources :users, only: [] do
    resources :notes, only: [:create]
  end
  resources :notes, only: [:index, :destroy]

  resources :daily_emotions, only: [:new]

  resources :appointments, only: [:show, :index, :destroy, :edit, :update]

  resources :home, only: [:index]

  resources :users do
    resources :appointments, only: [:create]
  end
  resources :class_memberships, only: [:destroy]
  resources :daily_emotions, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index', as: "landing"
  devise_for :user
end
