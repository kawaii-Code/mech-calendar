Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  root 'home#index'
  get 'about' => 'home#about'
  get 'calendar' => 'home#calendar'
  get 'today' => 'home#today'
  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'switch_lang' => 'application#switch_lang'
end
