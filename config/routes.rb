Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'occasions#index'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  get '/password_reset', to: 'password_reset#new'
  post '/password_reset', to: 'password_reset#create'

  patch '/occasions/:id/generate', to: 'occasions#generate', as: "occasion_generate"
  resources :occasions, only: [:show]
  resources :users, only: [:show, :edit, :update]

end
