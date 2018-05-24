Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  resources :bodies do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [] do
    resources :reviews, only: [:new, :create]
  end

  resources :conversations, only: [:index, :show]

  get "/dashboard", to: "pages#dashboard"
  get "/why_rent", to: "pages#why_rent"
end
