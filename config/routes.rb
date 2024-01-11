Rails.application.routes.draw do
  root to: "main#index"
  get "signup", to: "signup#new"
  post "signup", to: "signup#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "password", to: "passwords#edit"
  patch "password", to: "passwords#update"
end
