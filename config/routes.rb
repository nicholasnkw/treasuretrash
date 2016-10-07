Rails.application.routes.draw do
  root 'home#index'
  get '/search' => 'home#search'
  resources :postings do
    resources :comments
    resources :transactions
  end
  devise_for :users, :controllers => { 
    :omniauth_callbacks => "users/omniauth_callbacks",
    sessions: 'users/sessions' ,
    registrations: 'users/registrations'
  }
  resources :users, only: [:show, :update, :edit]
end