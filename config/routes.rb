Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :titles, only: %i[index show]
  resources :wrestlers, only: %i[show] do
    resources :reign, only: %i[show]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
