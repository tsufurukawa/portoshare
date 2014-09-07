Rails.application.routes.draw do
  root to: 'pages#front'

  resources :projects, only: [:index]  

  get '/sign_up', to: 'users#new'

  resources :users, only: [:show, :create, :edit, :update] do
    resources :projects, only: [:show, :new, :create]
    resources :authorizations, only: [:new]
    delete '/unlink_github', to: "authorizations#destroy"
  end


  get '/log_in', to: 'sessions#new'
  post '/log_in', to: 'sessions#create'
  delete '/log_out', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'authorizations#create'
  get '/auth/failure', to: 'authorizations#failure'
end