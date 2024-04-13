Rails.application.routes.draw do
  resources :awards
  resources :memberships
  resources :fire_departments
  resources :districts
  resources :regions
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "members" => "accounts#index", as: :accounts
  get "members/:id" => "accounts#show", as: :account
  get "members/:id/edit" => "accounts#edit", as: :edit_account
  patch "members/:id" => "accounts#update"
  delete "members/:id" => "accounts#destroy"
  get "new_member" => "accounts#new", as: :new_account
  # post "members" => "accounts#create"
  #post '/new_member', to: 'accounts#create', as: :new_member

  # Defines the root path route ("/")
  root "accounts#index"
end
