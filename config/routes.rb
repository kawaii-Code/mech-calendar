Rails.application.routes.draw do
  resources :passwords, param: :token

  root "home#index"
  get "about" => "home#about"
  get "calendar" => "home#calendar"
  post "signup" => "registrations#create"
  get "today" => "home#today"
  get "signup" => "registrations#new"
  get "up" => "rails/health#show", as: :rails_health_check
  get "switch_lang" => "application#switch_lang"

  get "login" => "sessions#new"
  post "login"  => "sessions#create"
  get "logout"  => "sessions#destroy"

  post "day/new" => "days#create"
  get "day/delete" => "days#delete"

  get "calendar_data" => "calendar#data"
end
