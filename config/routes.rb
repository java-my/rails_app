Rails.application.routes.draw do
  root to: "main#index"
  get "signup", to: "signup#new"
  post "signup", to: "signup#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "password", to: "passwords#edit"
  patch "password", to: "passwords#update"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"

  resources :articles
  resources :articles do
    resources :comments, only: %i[create destroy]
  end


  #メール
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
