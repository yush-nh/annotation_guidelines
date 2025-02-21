Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # For checking email in the development environment.
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "notes#index"

  resources :notes

  namespace :api do
    namespace :v1 do
      resources :notes, only: %i[create show update destroy]
    end
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    passwords: "users/passwords"
  }
  get "/users/:email" => "users#show", :constraints => { email: /.+@.+\..*/ }, as: "user"
end
