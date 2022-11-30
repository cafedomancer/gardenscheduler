Rails.application.routes.draw do
  resources :schedules do
    member do
      get :copy
    end
  end
 
  resources :tasks, only: [:update, :edit]
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
    registrations: 'users/registrations'
  }
  get 'tos' => 'top#tos'
  get 'pp' => 'top#pp'
  root to: 'top#index'
end
