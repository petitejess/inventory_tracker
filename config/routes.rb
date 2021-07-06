Rails.application.routes.draw do
  root 'home#index'
  resources :user_stocks
  resources :categories
  devise_for :users

  get '/user', to: 'user_stocks#index' , as: 'user_root'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
