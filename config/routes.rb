Rails.application.routes.draw do
  root 'home#index'
  resources :postings
  devise_for :users, :controllers => { 
    :omniauth_callbacks => "users/omniauth_callbacks",
    sessions: 'users/sessions' ,
    registrations: 'users/registrations'
  }

  # devise_for :users, :skip => [:registrations]
  # as :user do
  #   get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
  #   put 'users' => 'devise/registrations#update', :as => 'user_registrations'
  # end

  
  resources :users, only: [:show, :update, :edit]

end
