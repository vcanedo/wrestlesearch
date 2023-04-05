Rails.application.routes.draw do
  devise_for :users
  resources :titles, only: %i[index]
  resources :wrestlers, only: %i[index show] do
    resources :reigns, only: %i[show]
  end
  root to: "wrestlers#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
