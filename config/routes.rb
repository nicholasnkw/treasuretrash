Rails.application.routes.draw do
  root 'home#index'
  resources :postings do 
  	resources :comments
  end
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
