Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "endpoints#index"

  patch "endpoints/:id", to: "endpoints#update"
  resources :endpoints, except: [:show, :update]

  get '*path', to: 'errors#error_404', via: :all

  Endpoints::Router.load_endpoints_routes!
end
