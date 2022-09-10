Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "endpoints#index"

  patch "endpoints/:id", to: "endpoints#update"
  resources :endpoints, except: [:show, :update]

  Endpoints::Router.load_endpoints_routes!
end
