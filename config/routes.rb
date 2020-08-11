Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/edit'
  devise_for :users
  resources :restaurants do
  	resources :reviews, except: [:show, :index]
  end
  root 'restaurants#index'
  get 'pages/about'
  get 'pages/contact'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
