Rails.application.routes.draw do
  resources :schedules
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  root to: 'top#index'
end
