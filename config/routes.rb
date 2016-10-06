Rails.application.routes.draw do
  root 'home#index'
  resources :postings
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
