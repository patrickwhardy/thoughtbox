Rails.application.routes.draw do
  root to: "dashboard#show"
  resources :users, only: [:new, :create]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
end
